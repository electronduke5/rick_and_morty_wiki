import '../../data/models/location.dart';

class CharacterEntity{
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final bool? isFavorite;

  CharacterEntity({
   required this.id,
   required this.name,
   required this.status,
   required this.species,
   required this.type,
   required this.gender,
   required this.location,
   required this.image,
   required this.episode,
   required this.url,
    this.isFavorite = false,
});
}