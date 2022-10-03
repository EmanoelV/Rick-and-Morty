import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/characters/domain/use_case/character_usecase.dart';
import '../feature/characters/external/datasource/character_datasource_impl.dart';
import '../feature/characters/infra/repository/character_repository_impl.dart';
import '../feature/characters/presenter/characters_store.dart';
import '../feature/characters/presenter/favorites/favorites_characters_store.dart';

class Injector {
  static late SharedPreferences sharedPreferences;
  static final dio = _buildDio();
  static final characterDatasource =
      CharacterDatasourceImpl(dio, sharedPreferences);
  static final characterRepository =
      CharacterRepositoryImpl(characterDatasource);
  static final characterUseCase = CharacterUseCaseImpl(characterRepository);
  static CharactersStore get charactersStore =>
      CharactersStore(characterUseCase);
  static FavoritesCharactersStore get favoritesStore =>
      FavoritesCharactersStore(characterUseCase);

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Dio _buildDio() {
    final options = BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    final logInterceptor = LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        logPrint: (object) {
          log(object.toString(), name: 'dio', level: 0);
        });

    return Dio(options)..interceptors.add(logInterceptor);
  }
}
