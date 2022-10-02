import '../entity/character.dart';
import '../repository/character_repository.dart';

abstract class CharacterUseCase {
  Future<List<Character>> list(int page, String specie);
  Future<List<Character>> searchByName(String name, String specie);
}

class CharacterUseCaseImpl implements CharacterUseCase {
  final CharacterRepository _repository;

  CharacterUseCaseImpl(this._repository);

  @override
  Future<List<Character>> list(int page, String specie) async =>
      _repository.listCharacters(page, specie);

  @override
  Future<List<Character>> searchByName(String name, String specie) async =>
      _repository.searchCharacterByName(name, specie);
}
