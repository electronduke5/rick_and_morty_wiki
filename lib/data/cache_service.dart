import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_wiki/data/sources/hive_names.dart';
import 'package:rick_and_morty_wiki/domain/entities/hive_character.dart';

import '../presentation/di/app_module.dart';
import 'models/character.dart';

class CacheService {
  final _repository = AppModule.getCharacterRepository();

  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);

    Hive.registerAdapter(HiveCharacterAdapter());
    await Hive.openBox<HiveCharacter>(HiveBox.characters);
    await Hive.openBox<HiveCharacter>(HiveBox.favorites);
  }

  static Future<void> cacheCharacters(List<Character> characters) async {
    final box = Hive.box<HiveCharacter>(HiveBox.characters);
    final cachedIds = box.keys.cast<int>().toSet();
    final charactersToCache =
        characters
            .where((character) => !cachedIds.contains(character.id))
            .toList();
    if (charactersToCache.isNotEmpty) {
      await box.putAll({
        for (var c in charactersToCache)
          c.id: HiveCharacter.fromEntity(c, isFavorite: c.isFavorite),
      });
      print('Закешировано новых персонажей: ${charactersToCache.length}');
    } else {
      print('Все персонажи уже есть в кеше, пропускаем');
    }
  }

  // Получение кешированных персонажей
  static List<Character> getCachedCharacters() {
    return Hive.box<HiveCharacter>(
      HiveBox.characters,
    ).values.map((hiveChar) => hiveChar.toEntity()).toList();
  }

  Future<void> toggleFavorite(Character character) async {
    if (character.isFavorite!) {
      await _repository.removeFromFavourites(character.id);
    } else {
      await _repository.addToFavourites(character);
    }
  }

  static bool isFavorite(Character character) {
    return Hive.box<HiveCharacter>(HiveBox.favorites).get(character.id) != null;
  }
}


