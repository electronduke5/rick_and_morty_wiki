import 'package:rick_and_morty_wiki/data/api_service.dart';
import 'package:rick_and_morty_wiki/domain/repositories/location_repository.dart';

import '../models/location.dart';
import '../sources/api_const_urls.dart';

class LocationRepositoryImpl
    with ApiService<Location>
    implements LocationRepository {
  @override
  String apiRoute = ApiConstUrl.locationUrl;

  @override
  Future<Location> getLocation(int id) => get(
    fromJson: (Map<String, dynamic> json) => Location.fromJson(json),
    id: id,
  );

  @override
  Future<List<Location>> getLocations() =>
      getList(fromJson: (Map<String, dynamic> json) => Location.fromJson(json));
}
