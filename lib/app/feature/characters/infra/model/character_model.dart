import '../../domain/entity/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required String name,
    required String imageUrl,
    required String specie,
    required String status,
    required List<int> episodes,
    required DateTime created,
    required String id,
  }) : super(
          name: name,
          imageUrl: imageUrl,
          specie: specie,
          status: status,
          episodes: episodes,
          created: created,
          id: id,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        name: json['name'],
        imageUrl: json['image'],
        specie: json['species'],
        status: json['status'],
        episodes: List<String>.from(json['episode'])
            .map((e) => int.parse(e.split('/').last))
            .toList(),
        created: DateTime.parse(json['created']),
        id: json['id'].toString(),
      );

  factory CharacterModel.fromEntity(Character character) => CharacterModel(
        name: character.name,
        imageUrl: character.imageUrl,
        specie: character.specie,
        status: character.status,
        episodes: character.episodes,
        created: character.created,
        id: character.id,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': imageUrl,
        'species': specie,
        'status': status,
        'episode': episodes,
        'created': created.toIso8601String(),
        'id': id,
      };
}
