import '../entity/character.dart';

abstract class CharacterRepository {
  /// Get characters per page
  Future<List<Character>> listCharacters(int page, String specie);

  /// Get character by name
  Future<List<Character>> searchCharacterByName(String name, String specie);

  /// Change character favorite status
  Future<void> favorite(Character character);

  /// Get favorite characters
  Future<List<Character>> getFavorites();
}
