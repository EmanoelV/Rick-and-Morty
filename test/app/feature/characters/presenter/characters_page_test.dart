// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/entity/character.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/domain/repository/character_repository.dart';
import 'package:rick_and_morty/app/feature/characters/domain/use_case/character_usecase.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/characters_page.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/characters_store.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/widget/character_widget.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  // Test the CharactersPage widget

  late MockCharacterRepository mockCharacterRepository;
  late CharacterUseCase listCharacters;
  late CharactersStore store;
  late Widget page;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    listCharacters = CharacterUseCaseImpl(mockCharacterRepository);
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    store = CharactersStore(listCharacters);
    page = MaterialApp(home: CharactersPage(store));
  });

  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

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
        (_) async =>
            Future.delayed(const Duration(milliseconds: 300), () => []));
    // act
    await tester.runAsync(() async {
      store.listCharacters();
      await Future.delayed(const Duration(milliseconds: 100));
      await tester.pumpWidget(page);
    });

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

  testWidgets('should render linear loading when scroll to bottom',
      (tester) async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any())).thenAnswer(
        (_) async => Future.delayed(const Duration(milliseconds: 100),
            () => List.generate(10, (index) => Character('name', ''))));
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
      await tester.drag(find.byType(CharactersPage), const Offset(0, -1000));
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('should render CharacterPage with loading when search by name',
      (tester) async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => []);
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
      store.searchCharactersByName('name');
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should render CharacterPage with error when search by name',
      (tester) async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenThrow(ServerFailure());
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
      await store.searchCharactersByName('name');
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(ErrorWidget), findsOneWidget);
  });

  testWidgets('should render CharacterPage with characters when search by name',
      (tester) async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => [Character('name', '')]);
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
      await store.searchCharactersByName('name');
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(CharacterWidget), findsOneWidget);
  });

  testWidgets(
      'dont render linear loading when scroll to bottom when search by name',
      (tester) async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async {
      log('searchCharacterByName called');
      return Future.delayed(const Duration(milliseconds: 100),
          () => List.generate(10, (index) => Character('name', '')));
    });
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
      await store.searchCharactersByName('name');
      await tester.pumpWidget(page);
      await tester.drag(find.byType(CharactersPage), const Offset(0, -1000));
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });
  testWidgets(
      'should render CharacterPage with characters when wirite name and press search',
      (tester) async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => [Character('name', '')]);
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
      await tester.enterText(find.byType(TextField), 'name');
      await tester.tap(find.byType(SearchByTextButtonWidget));
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(CharacterWidget), findsOneWidget);
  });

  testWidgets(
      'should render CharacterPage with pagination when press reset filter',
      (tester) async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => [Character('name', '')]);
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => [Character('name', '')]);
    // act
    await tester.runAsync(() async {
      await store.listCharacters();
      await tester.pumpWidget(page);
      await tester.enterText(find.byType(TextField), 'name');
      await tester.tap(find.byType(SearchByTextButtonWidget));
      await tester.pumpWidget(page);
      await tester.tap(find.byType(ResetFilterButtonWidget));
      await tester.pumpWidget(page);
      await tester.drag(find.byType(CharactersPage), const Offset(0, -1000));
      await tester.pumpWidget(page);
    });
    // assert
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
