import '../entity/character.dart';
import '../repository/character_repository.dart';

abstract class ListCharacters {
  Future<List<Character>> call(int page);
}

class ListCharactersImpl implements ListCharacters {
  final CharacterRepository _repository;

  ListCharactersImpl(this._repository);

  @override
  Future<List<Character>> call(int page) async =>
      _repository.listCharacters(page);
}
