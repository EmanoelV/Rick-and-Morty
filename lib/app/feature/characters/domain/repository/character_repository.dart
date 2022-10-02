import '../entity/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> listCharacters(int page, String specie);
  Future<List<Character>> searchCharacterByName(String name, String specie);
}
