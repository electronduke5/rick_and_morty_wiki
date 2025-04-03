part of 'character_cubit.dart';

class CharacterState {
  final ApiState<List<Character>> getCharactersState;
  final ApiState<List<Character>> getFavoritesState;
  final ApiState<Character> getCharacterState;

  const CharacterState({
    this.getCharactersState = const IdleState(),
    this.getCharacterState = const IdleState(),
    this.getFavoritesState = const IdleState(),
  });

  CharacterState copyWith({
    ApiState<List<Character>>? getCharactersState,
    ApiState<Character>? getCharacterState,
    ApiState<List<Character>>? getFavoritesState,
  }) => CharacterState(
    getCharactersState: getCharactersState ?? this.getCharactersState,
    getCharacterState: getCharacterState ?? this.getCharacterState,
    getFavoritesState: getFavoritesState ?? this.getFavoritesState,
  );
}
