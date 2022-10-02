import '../model/character_model.dart';

abstract class CharacterDatasource {
  Future<List<CharacterModel>> listCharacters(int page, String specie);
  Future<List<CharacterModel>> searchCharacterByName(
      String name, String specie);
}
