import 'package:rick_and_morty_wiki/domain/entities/character.dart';

import 'location.dart';

class Character extends CharacterEntity {
  Character({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.location,
    required super.image,
    required super.episode,
    required super.url,
    super.isFavorite,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'location': location,
    'image': image,
    'episode': episode,
    'url': url,
    'is_favorite': isFavorite,
  };

  factory Character.fromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as int,
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'],
      episode: (json['episode'] as List<dynamic>).whereType<String>().toList(),
      url: json['url'],
      isFavorite: json['is_favorite'] ?? false
  );

  Character copyWith({int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    Location? location,
    String? image,
    List<String>? episode,
    String? url,
    bool? isFavorite,
  }) =>
      Character(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        species: species ?? this.species,
        type: type ?? this.type,
        gender: gender ?? this.gender,
        location: location ?? this.location,
        image: image ?? this.image,
        episode: episode ?? this.episode,
        url: url ?? this.url,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
