import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/app/feature/characters/domain/entity/character.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/detail/detail_character_page.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/util/asset.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/widget/character_widget.dart';
import 'package:rick_and_morty/app/routes/routes.dart';

Future<void> main() async {
  final character = Character(
      favorite: false,
      id: '1',
      name: 'name',
      imageUrl: Asset.noProfileImage,
      specie: '',
      status: '',
      episodes: [1, 2, 3],
      created: DateTime.now());
  final characterWidget = MaterialApp(
    routes: routes,
    home: Scaffold(body: CharacterWidget(character, onFavorite: (_) {})),
  );

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('should render character widget', (tester) async {
    // act
    await tester.pumpWidget(characterWidget);
    // assert
    expect(find.text('name'), findsOneWidget);
  });

  testWidgets('should open detail character page', (tester) async {
    // act
    await tester.runAsync(() async {
      await tester.pumpWidget(characterWidget);
      await tester.tap(find.byType(CharacterWidget));
      await tester.pumpWidget(characterWidget);
      await tester.pump();
    });
    // assert
    expect(find.byType(DetailCharacterPage), findsOneWidget);
  });
}
