import '../../domain/entity/character.dart';
import '../../domain/repository/character_repository.dart';
import '../datasource/character_datasource.dart';
import '../model/character_model.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDatasource _dataSource;

  CharacterRepositoryImpl(this._dataSource);

  @override
  Future<List<Character>> listCharacters(int page, String specie) async =>
      _dataSource.listCharacters(page, specie);

  @override
  Future<List<Character>> searchCharacterByName(
          String name, String specie) async =>
      _dataSource.searchCharacterByName(name, specie);

  @override
  Future<void> favorite(Character character) =>
      _dataSource.favorite(CharacterModel.fromEntity(character));

  @override
  Future<List<Character>> getFavorites() async {
    final favorites = await _dataSource.getFavorites();
    return favorites.map<Character>((e) => e.toEntity()).toList();
  }
}
