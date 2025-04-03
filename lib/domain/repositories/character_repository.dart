import 'package:rick_and_morty_wiki/data/models/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({int page = 1});
  Future<List<Character>> getFavoriteCharacters();

  Future<Character> getCharacter(int id);

  Future addToFavourites(Character character);

  Future removeToFavourites(int id);

  Stream<List<Character>> watchFavorites();
}
