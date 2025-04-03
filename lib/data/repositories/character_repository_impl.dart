import 'package:hive/hive.dart';
import 'package:rick_and_morty_wiki/domain/repositories/character_repository.dart';

import '../../domain/entities/hive_character.dart';
import '../api_service.dart';
import '../models/character.dart';
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
  Future<List<Character>> getFavoriteCharacters() async {
    try {
      if (!Hive.isBoxOpen(HiveBox.favorites)) {
        await Hive.openBox<HiveCharacter>(HiveBox.favorites);
      }
      final favoritesBox = Hive.box<HiveCharacter>(HiveBox.favorites).values.map((hiveChar) => hiveChar.toEntity()).toList();
      return favoritesBox;
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }

  @override
  Future addToFavourites(Character character) async {
    if (!Hive.isBoxOpen(HiveBox.favorites)) {
      await Hive.openBox<HiveCharacter>(HiveBox.favorites);
    }
    Box<HiveCharacter> favoritesBox = Hive.box<HiveCharacter>(HiveBox.favorites);
    if (!favoritesBox.containsKey(character.id)) {
      final hiveChar = HiveCharacter.fromEntity(character, isFavorite: true);
      print('Adding to favorites: ${hiveChar.isFavorite}');

      await favoritesBox.put(hiveChar.id, hiveChar);
    }
  }

  @override
  Stream<List<Character>> watchFavorites() {
    return Hive.box<HiveCharacter>(HiveBox.favorites).watch().map((_) {
      return Hive.box<HiveCharacter>(HiveBox.favorites).values.map((hiveChar) => hiveChar.toEntity()).toList();
    });
  }

   @override
  Future removeToFavourites(int id) async {
    Box<HiveCharacter> favoritesBox = Hive.box<HiveCharacter>(HiveBox.favorites);
    favoritesBox.delete(id);
  }
}
