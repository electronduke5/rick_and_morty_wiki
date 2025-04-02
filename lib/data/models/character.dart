import 'package:rick_and_morty_wiki/domain/models/character.dart';

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
    episode: json['episode'],
    url: json['url'],
    isFavorite: json['is_favorite'] ?? false
  );
}
