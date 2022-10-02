import '../../domain/entity/character.dart';

class CharacterModel extends Character {
  CharacterModel(String name, String imageUrl) : super(name, imageUrl);

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      CharacterModel(json['name'], json['image']);
}
