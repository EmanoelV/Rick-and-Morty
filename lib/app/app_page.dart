import 'package:flutter/material.dart';
import 'di/dependency.dart';
import 'feature/characters/presenter/characters_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: CharactersPage(Dependency.charactersStore),
      );
}
