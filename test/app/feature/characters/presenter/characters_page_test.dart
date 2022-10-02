import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/entity/character.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/domain/repository/character_repository.dart';
import 'package:rick_and_morty/app/feature/characters/domain/use_case/list_characters.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/characters_page.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/characters_store.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/widget/character_widget.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  // Test the CharactersPage widget

  late MockCharacterRepository mockCharacterRepository;
  late ListCharacters listCharacters;
  late CharactersStore store;
  late Widget page;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    listCharacters = ListCharactersImpl(mockCharacterRepository);
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    store = CharactersStore(listCharacters);
    page = MaterialApp(home: CharactersPage(store));
  });

  testWidgets('should render CharactersPage', (tester) async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await tester.pumpWidget(page);
    // assert
    expect(find.byType(CharactersPage), findsOneWidget);
  });

  testWidgets('should render CharactersPage with loading', (tester) async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any())).thenAnswer(
        (_) async => Future.delayed(const Duration(seconds: 1), () => []));
    // act
    store.listCharacters();
    await tester.pumpWidget(page);

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should render CharactersPage with error', (tester) async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenThrow(ServerFailure());
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(ErrorWidget), findsOneWidget);
  });

  testWidgets('should render CharactersPage with characters', (tester) async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => [Character('name', '')]);
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(CharacterWidget), findsOneWidget);
  });
}
