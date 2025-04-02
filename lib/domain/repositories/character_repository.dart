import 'package:rick_and_morty_wiki/data/models/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters();
  Future<List<Character>> getFavouriteCharacters();

  Future<Character> getCharacter(int id);

  Future<Character> addToFavourites(int id);

  Future<Character> removeToFavourites(int id);
}
