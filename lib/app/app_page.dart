import 'package:flutter/material.dart';
import 'di/dependency.dart';
import 'feature/characters/presenter/characters_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: CharactersPage(Dependency.charactersStore),
      );
}
