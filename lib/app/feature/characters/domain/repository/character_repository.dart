import '../entity/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> listCharacters(int page);
  Future<List<Character>> searchCharacterByName(String name);
}
