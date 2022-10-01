import '../model/character_model.dart';

abstract class CharacterDatasource {
  Future<List<CharacterModel>> listCharacters(int page);
}
