import 'package:hive/hive.dart';

import '../../data/models/character.dart';
import '../../data/models/location.dart';

part 'hive_character.g.dart';

@HiveType(typeId: 0)
class HiveCharacter {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String gender;

  @HiveField(3)
  final String status;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final bool isFavorite;

  HiveCharacter({
    required this.id,
    required this.name,
    required this.gender,
    required this.status,
    required this.image,
    this.isFavorite = false,
  });

  // Конвертер из CharacterEntity
  factory HiveCharacter.fromEntity(Character entity, {bool? isFavorite}) {
    return HiveCharacter(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      gender: entity.gender,
      image: entity.image,
      isFavorite: isFavorite ?? entity.isFavorite ?? false,
    );
  }

  // Конвертер в CharacterEntity
  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: '',
      type: '',
      gender: gender,
      location: Location(name: '', url: ''),
      image: image,
      episode: [],
      url: '',
      isFavorite: isFavorite,
    );
  }
}
