import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/api_state.dart';

import '../../../data/models/character.dart';
import '../../di/app_module.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(const CharacterState());
  final List<Character> _allCharacters = [];
  bool _hasReachedMax = false;


  final _repository = AppModule.getCharacterRepository();

  Future loadAllCharacters({int page = 1}) async {
    if (page == 1) {
      emit(state.copyWith(getCharactersState: LoadingState()));
    } else {
      emit(state.copyWith(
          getCharactersState: PartiallyLoadedState(List.from(_allCharacters))));
    }

    try {
      List<Character> newCharacters = await _repository.getCharacters(
          page: page);
      if (newCharacters.isEmpty) {
        _hasReachedMax = true;
        return;
      }
      _allCharacters.addAll(newCharacters);
      emit(state.copyWith(
          getCharactersState: LoadedState(List.from(_allCharacters))));
    } catch (e) {
      emit(state.copyWith(getCharactersState: FailedState(e.toString())));
    }
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

  Future<List<Character>> loadFavorites() async {
    emit(state.copyWith(getFavoritesState: LoadingState()));

    try {
      final favorites = await _repository.getFavoriteCharacters();
      emit(state.copyWith(
        getFavoritesState: LoadedState(favorites),
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

  Future addToFavourites(Character character) async {
    await _repository.addToFavourites(character);
    await loadFavorites();
  }

  Future removeFromFavourites(int id) async {
    await _repository.removeToFavourites(id);
    await loadFavorites();
  }
}
