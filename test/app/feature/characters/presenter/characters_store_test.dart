import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/entity/character.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/domain/repository/character_repository.dart';
import 'package:rick_and_morty/app/feature/characters/domain/use_case/list_characters.dart';
import 'package:rick_and_morty/app/feature/characters/presenter/characters_store.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late MockCharacterRepository mockCharacterRepository;
  late ListCharacters listCharacters;
  late CharactersStore store;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    listCharacters = ListCharactersImpl(mockCharacterRepository);
    store = CharactersStore(listCharacters);
  });

  test('should list characters', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters(1);
    // assert
    expect(store.characters, []);
  });

  test('should reset store', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters(1);
    store.reset();
    // assert
    expect(store.characters, []);
    expect(store.loading, false);
    expect(store.error, null);
  });

  test('should set loading to true', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters(1);
    // assert
    expect(store.loading, false);
  });

  test('should set error', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenThrow(ServerFailure());
    // act
    await store.listCharacters(1);
    // assert
    expect(store.error, isNotNull);
  });

  test('should set hasError to true', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenThrow(ServerFailure());
    // act
    await store.listCharacters(1);
    // assert
    expect(store.hasError, true);
  });

  test('should set hasCharacters to true', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => [Character('', '')]);
    // act
    await store.listCharacters(1);
    // assert
    expect(store.hasCharacters, true);
  });

  test('should set hasCharacters to false', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters(1);
    store.reset();
    // assert
    expect(store.hasCharacters, false);
  });

  test('should set hasError to false', () async {
    // arrange
    when(() => mockCharacterRepository.listCharacters(any()))
        .thenAnswer((_) async => []);
    // act
    await store.listCharacters(1);
    // assert
    expect(store.hasError, false);
  });
}
