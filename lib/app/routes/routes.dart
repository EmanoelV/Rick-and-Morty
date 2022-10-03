import 'package:flutter/material.dart';

import '../di/dependency.dart';
import '../feature/characters/domain/entity/character.dart';
import '../feature/characters/presenter/characters_page.dart';
import '../feature/characters/presenter/detail/detail_character_page.dart';

Map<String, WidgetBuilder> routes = {
  '/characters': (context) => CharactersPage(Injector.charactersStore),
  '/detail': (context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;
    return DetailCharacterPage(character);
  },
};
