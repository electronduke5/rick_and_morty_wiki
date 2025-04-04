part of 'character_cubit.dart';

class CharacterState {
  final ApiState<List<Character>> getCharactersState;
  final ApiState<List<Character>> getFavoritesState;
  final ApiState<Character> getCharacterState;
  final int page;

  const CharacterState({
    this.getCharactersState = const IdleState(),
    this.getCharacterState = const IdleState(),
    this.getFavoritesState = const IdleState(),
    this.page = 1,
  });

  CharacterState copyWith({
    ApiState<List<Character>>? getCharactersState,
    ApiState<Character>? getCharacterState,
    ApiState<List<Character>>? getFavoritesState,
    int? page,
  }) => CharacterState(
    getCharactersState: getCharactersState ?? this.getCharactersState,
    getCharacterState: getCharacterState ?? this.getCharacterState,
    getFavoritesState: getFavoritesState ?? this.getFavoritesState,
    page: page ?? this.page,
  );
}
