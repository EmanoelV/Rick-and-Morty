import 'package:dio/dio.dart';

import '../../infra/datasource/character_datasource.dart';
import '../../infra/model/character_model.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final Dio _dio;

  CharacterDatasourceImpl(this._dio);

  @override
  Future<List<CharacterModel>> listCharacters(int page, String specie) => _dio
      .get('/character/?page=$page&species=$specie')
      .then((response) =>
          List<Map<String, dynamic>>.from(response.data['results']))
      .then((results) =>
          results.map<CharacterModel>(CharacterModel.fromJson).toList());

  @override
  Future<List<CharacterModel>> searchCharacterByName(
          String name, String specie) =>
      _dio
          .get('/character/?name=$name&species=$specie')
          .then((response) =>
              List<Map<String, dynamic>>.from(response.data['results']))
          .then((results) =>
              results.map<CharacterModel>(CharacterModel.fromJson).toList());
}
