import 'package:rick_and_morty_wiki/data/utils/api_const_urls.dart';

import '../api_service.dart';
import '../models/character.dart';
import 'package:rick_and_morty_wiki/domain/repositories/character_repository.dart';

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
  Future<List<Character>> getCharacters() => getList(
    fromJson: (Map<String, dynamic> json) => Character.fromJson(json),
  );

  @override
  Future<List<Character>> getFavouriteCharacters() {
    // TODO: implement getFavouriteCharacters with DB service
    throw UnimplementedError();
  }

  @override
  Future<Character> addToFavourites(int id) {
    // TODO: implement addToFavourites with DB service
    throw UnimplementedError();
  }

   @override
  Future<Character> removeToFavourites(int id) {
    // TODO: implement removeToFavourites with DB service
    throw UnimplementedError();
  }
}
