import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/app/feature/characters/domain/entity/character.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/detail/detail_character_page.dart';

void main() {
  final detailCharacterPage = MaterialApp(
    home: DetailCharacterPage(
      Character(
        favorite: false,
        id: '1',
        name: 'name',
        imageUrl: 'imageUrl',
        specie: 'specie',
        status: 'status',
        episodes: [1, 2, 3],
        created: DateTime.now(),
      ),
    ),
  );

  testWidgets('should render detail character page', (tester) async {
    // act
    await tester.pumpWidget(detailCharacterPage);
    // assert
    expect(find.text('name'), findsOneWidget);
    expect(find.text('specie'), findsOneWidget);
    expect(find.text('status'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });
}
