part of 'character_cubit.dart';

class CharacterState {
  final ApiState<List<Character>> getCharactersState;
  final ApiState<Character> getCharacterState;

  const CharacterState({
    this.getCharactersState = const IdleState(),
    this.getCharacterState = const IdleState(),
  });

  CharacterState copyWith({
    ApiState<List<Character>>? getCharactersState,
    ApiState<Character>? getCharacterState,
  }) => CharacterState(
    getCharactersState: getCharactersState ?? this.getCharactersState,
    getCharacterState: getCharacterState ?? this.getCharacterState,
  );
}
