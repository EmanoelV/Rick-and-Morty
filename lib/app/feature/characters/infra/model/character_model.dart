import '../../domain/entity/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required String name,
    required String imageUrl,
    required String specie,
    required String status,
    required List<int> episodes,
    required DateTime created,
  }) : super(
          name: name,
          imageUrl: imageUrl,
          specie: specie,
          status: status,
          episodes: episodes,
          created: created,
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
      );
}
