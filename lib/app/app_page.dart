import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'feature/characters/domain/use_case/list_characters.dart';
import 'feature/characters/external/datasource/character_datasource_impl.dart';
import 'feature/characters/infra/repository/character_repository_impl.dart';
import 'feature/characters/presenter/characters_page.dart';
import 'feature/characters/presenter/characters_store.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: CharactersPage(CharactersStore(ListCharactersImpl(
            CharacterRepositoryImpl(CharacterDatasourceImpl(Dio()))))),
      );
}
