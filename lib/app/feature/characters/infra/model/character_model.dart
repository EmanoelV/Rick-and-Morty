import '../../domain/entity/character.dart';

class CharacterModel extends Character {
  CharacterModel(
    String name,
    String imageUrl,
    String specie,
  ) : super(
          name: name,
          imageUrl: imageUrl,
          specie: specie,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        json['name'] as String,
        json['image'] as String,
        json['species'] as String,
      );
}
