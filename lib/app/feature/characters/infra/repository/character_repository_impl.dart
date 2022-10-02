import '../../domain/entity/character.dart';
import '../../domain/repository/character_repository.dart';
import '../datasource/character_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDatasource _dataSource;

  CharacterRepositoryImpl(this._dataSource);

  @override
  Future<List<Character>> listCharacters(int page) async =>
      _dataSource.listCharacters(page);

  @override
  Future<List<Character>> searchCharacterByName(String name) async =>
      _dataSource.searchCharacterByName(name);
}
