class LocationEntity {
  late int? id;
  final String name;
  final String? type;
  final String? dimension;
  final List<String>? residents;
  final String url;

  LocationEntity({
    this.id = 0,
    required this.name,
    this.type,
    this.dimension,
    this.residents,
    required this.url,
  });
}
