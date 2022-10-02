import 'package:dio/dio.dart';

import '../feature/characters/domain/use_case/character_usecase.dart';
import '../feature/characters/external/datasource/character_datasource_impl.dart';
import '../feature/characters/infra/repository/character_repository_impl.dart';
import '../feature/characters/presenter/characters_store.dart';

class Dependency {
  static final dio = _buildDio();
  static final characterDatasource = CharacterDatasourceImpl(dio);
  static final characterRepository =
      CharacterRepositoryImpl(characterDatasource);
  static final characterUseCase = CharacterUseCaseImpl(characterRepository);
  static final charactersStore = CharactersStore(characterUseCase);

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
    );

    return Dio(options)..interceptors.add(logInterceptor);
  }
}
