import '../entity/character.dart';
import '../error/error.dart';
import '../repository/character_repository.dart';

abstract class CharacterUseCase {
  /// Get characters per page and specie
  Future<List<Character>> list(int page, String specie);

  /// Get character by name and specie
  Future<List<Character>> searchByName(String name, String specie);

  /// Change character favorite status
  Future<void> favorite(Character character);

  /// Get favorite characters
  Future<List<Character>> getFavorites();
}

class CharacterUseCaseImpl implements CharacterUseCase {
  final CharacterRepository _repository;

  CharacterUseCaseImpl(this._repository);

  @override
  Future<List<Character>> list(int page, String specie) async {
    try {
      final characters = await _repository.listCharacters(page, specie);
      return characters;
    } on Failure catch (e) {
      if (e is NotFoundFailure) {
        return [];
      }
      rethrow;
    }
  }

  @override
  Future<List<Character>> searchByName(String name, String specie) async =>
      _repository.searchCharacterByName(name, specie);

  @override
  Future<void> favorite(Character character) => _repository.favorite(character);

  @override
  Future<List<Character>> getFavorites() => _repository.getFavorites();
}
