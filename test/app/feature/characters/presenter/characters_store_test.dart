import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/entity/character.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/domain/repository/character_repository.dart';
import 'package:rick_and_morty/app/feature/characters/domain/use_case/character_usecase.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/characters_store.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late MockCharacterRepository mockCharacterRepository;
  late CharacterUseCase listCharacters;
  late CharactersStore store;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    listCharacters = CharacterUseCaseImpl(mockCharacterRepository);
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    store = CharactersStore(listCharacters);
  });

  test('should list characters', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters();
    // assert
    expect(store.characters, []);
  });

  test('should reset store', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters();
    store.reset();
    // assert
    expect(store.characters, []);
    expect(store.loading, false);
    expect(store.error, null);
    expect(store.page, 1);
  });

  test('should set loading to true', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters();
    // assert
    expect(store.loading, false);
  });

  test('should set error', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenThrow(ServerFailure());
    // act
    await store.listCharacters();
    // assert
    expect(store.error, isNotNull);
  });

  test('should set hasError to true', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenThrow(ServerFailure());
    // act
    await store.listCharacters();
    // assert
    expect(store.hasError, true);
  });

  test('should set hasCharacters to true', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => [Character('', '')]);
    // act
    await store.listCharacters();
    // assert
    expect(store.hasCharacters, true);
  });

  test('should set hasCharacters to false', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters();
    store.reset();
    // assert
    expect(store.hasCharacters, false);
  });

  test('should set hasError to false', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters();
    // assert
    expect(store.hasError, false);
  });

  test('should set page to 5', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    store.listCharacters();
    store.listCharacters();
    store.listCharacters();

    await store.awaitLoading();

    // assert
    expect(store.page, 5);
  });

  test('should set pagination to false', () async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => []);
    // act
    await store.searchCharactersByName('name');
    // assert
    expect(store.pagination, false);
  });

  test('should set pagination to true', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.clearFilter();
    // assert
    expect(store.pagination, true);
  });

  test('should list characters by name', () async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => []);
    // act
    await store.searchCharactersByName('name');
    // assert
    expect(store.characters, []);
  });

  test('should set loading to true when search characters by name', () async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => []);
    // act
    await store.searchCharactersByName('name');
    // assert
    expect(store.loading, false);
  });

  test('should set error when search characters by name', () async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenThrow(ServerFailure());
    // act
    await store.searchCharactersByName('name');
    // assert
    expect(store.error, isNotNull);
  });

  test('should set hasError to true when search characters by name', () async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenThrow(ServerFailure());
    // act
    await store.searchCharactersByName('name');
    // assert
    expect(store.hasError, true);
  });

  test('should set hasCharacters to true when search characters by name',
      () async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => [Character('', '')]);
    // act
    await store.searchCharactersByName('name');
    // assert
    expect(store.hasCharacters, true);
  });

  test('should set hasCharacters to false when search characters by name',
      () async {
    // arrange
    when(() => mockCharacterRepository.searchCharacterByName(any()))
        .thenAnswer((_) async => []);
    // act
    await store.searchCharactersByName('name');
    store.reset();
    // assert
    expect(store.hasCharacters, false);
  });
}
