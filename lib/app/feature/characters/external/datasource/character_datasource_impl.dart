import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infra/datasource/character_datasource.dart';
import '../../infra/model/character_model.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  CharacterDatasourceImpl(this._dio, this._sharedPreferences);

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

  @override
  Future<void> favorite(CharacterModel character) async {
    const favoritesKey = 'favorites';
    final favorites = _sharedPreferences.getStringList(favoritesKey) ?? [];
    final favoritesMap = favorites.map((e) {
      final json = jsonDecode(e);
      return CharacterModel.fromJson(json);
    }).toList();

    final index = favoritesMap.indexWhere((e) => e.id == character.id);

    if (index == -1) {
      favoritesMap.add(character);
    } else {
      favoritesMap.removeAt(index);
    }

    final favoritesJson = favoritesMap.map((e) => jsonEncode(e.toJson()));

    await _sharedPreferences.setStringList(
        favoritesKey, favoritesJson.toList());

    return;
  }
}
