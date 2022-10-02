import '../entity/character.dart';
import '../repository/character_repository.dart';

abstract class CharacterUseCase {
  Future<List<Character>> list(int page);
  Future<List<Character>> searchByName(String name);
}

class CharacterUseCaseImpl implements CharacterUseCase {
  final CharacterRepository _repository;

  CharacterUseCaseImpl(this._repository);

  @override
  Future<List<Character>> list(int page) async =>
      _repository.listCharacters(page);

  @override
  Future<List<Character>> searchByName(String name) async =>
      _repository.searchCharacterByName(name);
}
