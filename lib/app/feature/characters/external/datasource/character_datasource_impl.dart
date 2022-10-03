import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/error/error.dart';
import '../../infra/datasource/character_datasource.dart';
import '../../infra/model/character_model.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  CharacterDatasourceImpl(this._dio, this._sharedPreferences);

  dynamic _responseError(dynamic error) {
    if (error is DioError) {
      if (error.response?.statusCode == 404) {
        throw NotFoundFailure();
      }
      throw error;
    }
    throw error;
  }

  Future<List<CharacterModel>> _setFavorites(
      List<CharacterModel> characters) async {
    final favorites = await getFavorites();
    for (var character in characters) {
      character.favorite =
          favorites.where((e) => e.id == character.id).isNotEmpty;
    }
    return characters;
  }

  @override
  Future<List<CharacterModel>> listCharacters(int page, String specie) async {
    try {
      final response = await _dio.get('/character/?page=$page&species=$specie');
      final list = List<Map<String, dynamic>>.from(response.data['results']);
      final characters =
          list.map<CharacterModel>(CharacterModel.fromJson).toList();
      final charactersWithFavorite = _setFavorites(characters);
      return charactersWithFavorite;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      throw _responseError(e);
    }
  }

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
    final favorites = await getFavorites();

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

  @override
  Future<List<CharacterModel>> getFavorites() async {
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
