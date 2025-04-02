import '../../data/models/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocations();

  Future<Location> getLocation(int id);
}
