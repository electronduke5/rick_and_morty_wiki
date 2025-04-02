import 'package:hive/hive.dart';

import '../api_service.dart';
import '../models/character.dart';
import 'package:rick_and_morty_wiki/domain/repositories/character_repository.dart';

import '../sources/api_const_urls.dart';
import '../sources/hive_names.dart';

class CharacterRepositoryImpl
    with ApiService<Character>
    implements CharacterRepository {
  @override
  String apiRoute = ApiConstUrl.characterUrl;

  @override
  Future<Character> getCharacter(int id) => get(
    fromJson: (Map<String, dynamic> json) => Character.fromJson(json),
    id: id,
  );

  @override
  Future<List<Character>> getCharacters({int page = 1}) => getList(
    fromJson: (Map<String, dynamic> json) => Character.fromJson(json),
    params: {'page': page},
  );

  @override
  Future<List<Character>> getFavouriteCharacters() async {
    Box<Character> favoritesBox = Hive.box<Character>(HiveBox.favorites);
    return favoritesBox.values.toList();
  }

  @override
  Future addToFavourites(Character character) async {
    Box<Character> favoritesBox = Hive.box<Character>(HiveBox.favorites);
    favoritesBox.put(character.id, character);
  }

   @override
  Future removeToFavourites(int id) async {
    Box<Character> favoritesBox = Hive.box<Character>(HiveBox.favorites);
    favoritesBox.delete(id);
  }
}
