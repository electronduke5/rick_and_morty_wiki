import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/api_state.dart';

import '../../../data/models/character.dart';
import '../../di/app_module.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(const CharacterState());
  final List<Character> _allCharacters = [];

  final _repository = AppModule.getCharacterRepository();

  Future loadAllCharacters({int? page}) async {
    final currentPage = page ?? state.page;
    if (currentPage == 1) {
      emit(state.copyWith(
          getCharactersState: LoadingState(), page: currentPage));
    } else {
      emit(state.copyWith(
          getCharactersState: PartiallyLoadedState(List.from(_allCharacters)),
          page: currentPage));
    }

    try {
      List<Character> newCharacters = await _repository.getCharacters(
          page: currentPage);

      Set<int> favoritesIds = await _repository.getFavoritesIds();
      final updatedCharacters = newCharacters.map((character) {
        return character.copyWith(
          isFavorite: favoritesIds.contains(character.id),
        );
      }).toList();
      final newIds = newCharacters.map((c) => c.id).toSet();
      _allCharacters.removeWhere((c) => newIds.contains(c.id));
      _allCharacters.addAll(updatedCharacters);

      emit(state.copyWith(
          getCharactersState: LoadedState(List.from(_allCharacters)),
          page: currentPage));
    } catch (e) {
      emit(state.copyWith(
          getCharactersState: FailedState(e.toString()), page: currentPage));
    }
  }

  Future setPage(int page) async {
    state.copyWith(page: page);
  }

  Future loadCharacter(int id) async {
    emit(state.copyWith(getCharacterState: LoadingState()));
    try {
      Character character = await _repository.getCharacter(id);
      emit(state.copyWith(getCharacterState: LoadedState(character)));
    } catch (e) {
      emit(state.copyWith(getCharacterState: FailedState(e.toString())));
    }
  }

  Future<List<Character>> loadFavorites({int? sortType}) async {
    emit(state.copyWith(getFavoritesState: LoadingState()));

    try {
      final favorites = await _repository.getFavoriteCharacters();
      final sortedFavorites = _sortFavorites(favorites, sortType);
      emit(state.copyWith(
        getFavoritesState: LoadedState(sortedFavorites),
      ));
    } catch (e) {
      emit(state.copyWith(
        getFavoritesState: FailedState(e.toString()),
      ));
    }
    return await _repository.getFavoriteCharacters();
  }

  Stream<List<Character>> watchFavorites() {
    return _repository.watchFavorites();
  }

  List<Character> _sortFavorites(List<Character> favorites, int? sortType) {
    switch (sortType) {
      case 1: // default
        return favorites;
      case 2: // по имени
        return favorites..sort((a, b) => a.name.compareTo(b.name));
      case 3: // сначала живые
        return favorites
          ..sort((a, b) {
            if (a.status == 'Alive' && b.status != 'Alive') return -1;
            if (a.status != 'Alive' && b.status == 'Alive') return 1;
            return a.name.compareTo(b.name);
          });
      case 4: // сначала мертвые
        return favorites
          ..sort((a, b) {
            if (a.status == 'Dead' && b.status != 'Dead') return -1;
            if (a.status != 'Dead' && b.status == 'Dead') return 1;
            return a.name.compareTo(b.name);
          });
      default:
        return favorites;
    }
  }

  Future<void> toggleFavorite(Character character) async {
    try {
      if (character.isFavorite!) {
        await _repository.removeFromFavourites(character.id);
        await loadFavorites();
      } else {
        await _repository.addToFavourites(character);
      }

      // Обновляем состояние в списке
      final updatedCharacters = state.getCharactersState.item?.map((c) {
        return c.id == character.id
            ? c.copyWith(isFavorite: !c.isFavorite!)
            : c;
      }).toList();

      emit(state.copyWith(
        getCharactersState: LoadedState(updatedCharacters ?? []),
      ));
    } catch (e) {
      emit(state.copyWith(
        getCharactersState: FailedState('Failed to toggle favorite'),
      ));
    }
  }

}
