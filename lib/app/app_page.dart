import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'feature/characters/domain/use_case/character_usecase.dart';
import 'feature/characters/external/datasource/character_datasource_impl.dart';
import 'feature/characters/infra/repository/character_repository_impl.dart';
import 'feature/characters/presenter/characters_page.dart';
import 'feature/characters/presenter/characters_store.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: CharactersPage(CharactersStore(CharacterUseCaseImpl(
            CharacterRepositoryImpl(CharacterDatasourceImpl(Dio(
          BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'),
        )))))),
      );
}
