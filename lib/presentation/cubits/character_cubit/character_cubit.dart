import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/api_state.dart';

import '../../../data/models/character.dart';
import '../../di/app_module.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(const CharacterState());

  final _repository = AppModule.getCharacterRepository();

  Future<void> loadAllCharacters() async {
    emit(state.copyWith(getCharactersState: LoadingState()));
    try {
      List<Character> characters = await _repository.getCharacters();
      emit(state.copyWith(getCharactersState: LoadedState(characters)));
    } catch (e) {
      emit(state.copyWith(getCharactersState: FailedState(e.toString())));
    }
  }

  Future<void> loadCharacter(int id) async {
    emit(state.copyWith(getCharacterState: LoadingState()));
    try {
      Character character = await _repository.getCharacter(id);
      emit(state.copyWith(getCharacterState: LoadedState(character)));
    } catch (e) {
      emit(state.copyWith(getCharacterState: FailedState(e.toString())));
    }
  }
}
