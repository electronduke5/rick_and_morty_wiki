import 'package:rick_and_morty_wiki/domain/entities/location.dart';

class Location extends LocationEntity {
  Location({
    super.id,
    required super.name,
    super.type,
    super.dimension,
    super.residents,
    required super.url,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'dimension': dimension,
    'residents': residents,
    'url': url,
  };

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    dimension: json['dimension'],
    residents: json['residents'],
    url: json['url'],
  );
}
