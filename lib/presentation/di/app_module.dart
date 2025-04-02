import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_wiki/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_wiki/data/repositories/location_repository_impl.dart';
import 'package:rick_and_morty_wiki/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_wiki/domain/repositories/location_repository.dart';

class AppModule {
  static bool _provided = false;

  void provideDependencies() {
    if (_provided) return;
    _provideLocationRepository();
    _provideCharacterRepository();
    _provided = true;
  }

  void _provideLocationRepository() =>
      GetIt.instance.registerSingleton(LocationRepositoryImpl());

  static LocationRepository getLocationRepository() =>
      GetIt.instance.get<LocationRepositoryImpl>();

  void _provideCharacterRepository() =>
      GetIt.instance.registerSingleton(LocationRepositoryImpl());

  static CharacterRepository getCharacterRepository() =>
      GetIt.instance.get<CharacterRepositoryImpl>();
}
