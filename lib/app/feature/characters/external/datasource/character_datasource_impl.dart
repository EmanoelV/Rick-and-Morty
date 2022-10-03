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
          .then((results) {
        final characters =
            results.map<CharacterModel>(CharacterModel.fromJson).toList();
        // set favorites
        final favorites = _getFavorites();
        for (var character in characters) {
          character.favorite =
              favorites.where((e) => e.id == character.id).isNotEmpty;
        }
        return characters;
      });

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
    final favorites = _getFavorites();

    final index = favorites.indexWhere((e) => e.id == character.id);

    if (index == -1) {
      favorites.add(character);
    } else {
      favorites.removeAt(index);
    }

    final favoritesJson = favorites.map((e) => jsonEncode(e.toJson()));

    await _sharedPreferences.setStringList(
        favoritesKey, favoritesJson.toList());
  }

  List<CharacterModel> _getFavorites() {
    const favoritesKey = 'favorites';
    final favorites = _sharedPreferences.getStringList(favoritesKey) ?? [];
    late List<CharacterModel> characters;
    try {
      characters = favorites.map((e) {
        final json = jsonDecode(e);
        return CharacterModel.fromJson(json);
      }).toList();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      _sharedPreferences.remove(favoritesKey);
      characters = <CharacterModel>[];
    }
    return characters;
  }
}
