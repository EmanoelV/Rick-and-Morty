import 'package:dio/dio.dart';

import '../../infra/datasource/character_datasource.dart';
import '../../infra/model/character_model.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final Dio _dio;

  CharacterDatasourceImpl(this._dio);

  @override
  Future<List<CharacterModel>> listCharacters(int page) => _dio
      .get('/character/?page=$page')
      .then((response) =>
          List<Map<String, dynamic>>.from(response.data['results']))
      .then((results) =>
          results.map<CharacterModel>(CharacterModel.fromJson).toList());
}
