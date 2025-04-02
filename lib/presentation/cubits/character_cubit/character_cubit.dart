import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/api_state.dart';

import '../../../data/models/character.dart';
import '../../di/app_module.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(const CharacterState());

  final _repository = AppModule.getCharacterRepository();

  Future loadAllCharacters({int page = 1}) async {
    emit(state.copyWith(getCharactersState: LoadingState()));
    try {
      List<Character> characters = await _repository.getCharacters(page: page);
      emit(state.copyWith(getCharactersState: LoadedState(characters)));
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

  Future<List<Character>> loadFavourites() async =>
      await _repository.getFavouriteCharacters();

  Future addToFavourites(Character character) async =>
      await _repository.addToFavourites(character);

  Future removeToFavourites(int id) async =>
      await _repository.removeToFavourites(id);
}
