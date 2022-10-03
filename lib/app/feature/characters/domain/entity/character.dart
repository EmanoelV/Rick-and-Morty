class Character {
  final String name, imageUrl, specie, status;
  final List<int> episodes;
  final DateTime created;

  Character({
    required this.name,
    required this.imageUrl,
    required this.specie,
    required this.status,
    required this.episodes,
    required this.created,
  });
}
