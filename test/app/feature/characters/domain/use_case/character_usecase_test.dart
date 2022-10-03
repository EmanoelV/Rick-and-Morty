import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/entity/character.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/domain/repository/character_repository.dart';
import 'package:rick_and_morty/app/feature/characters/domain/use_case/character_usecase.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late MockCharacterRepository mockCharacterRepository;
  late CharacterUseCase characterUseCase;
  final character = Character(
    favorite: false,
    id: '1',
    name: 'name',
    imageUrl: 'imageUrl',
    specie: '',
    status: '',
    episodes: [],
    created: DateTime.now(),
  );

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    characterUseCase = CharacterUseCaseImpl(mockCharacterRepository);
    registerFallbackValue(character);
  });

  group('list', () {
    test('should list characters', () async {
      // arrange
      when(() => mockCharacterRepository.listCharacters(any(), any()))
          .thenAnswer((_) async => []);
      // act
      await characterUseCase.list(1, '');
      // assert
      verify(() => mockCharacterRepository.listCharacters(1, '')).called(1);
    });

    test('should throw a failure', () async {
      // arrange
      when(() => mockCharacterRepository.listCharacters(any(), any()))
          .thenThrow(ServerFailure());
      // act
      final call = characterUseCase.list;
      // assert
      expect(() => call(1, ''), throwsA(isA<Failure>()));
    });
  });

  group('searchByName', () {
    test('should search characters by name', () async {
      // arrange
      when(() => mockCharacterRepository.searchCharacterByName(any(), any()))
          .thenAnswer((_) async => []);
      // act
      await characterUseCase.searchByName('Rick', '');
      // assert
      verify(() => mockCharacterRepository.searchCharacterByName('Rick', ''))
          .called(1);
    });

    test('should throw a failure', () async {
      // arrange
      when(() => mockCharacterRepository.searchCharacterByName(any(), any()))
          .thenThrow(ServerFailure());
      // act
      final call = characterUseCase.searchByName;
      // assert
      expect(() => call('Rick', ''), throwsA(isA<Failure>()));
    });
  });

  group('favorite', () {
    test('should favorite a character', () async {
      // arrange
      when(() => mockCharacterRepository.favorite(any()))
          .thenAnswer((_) async => character);
      // act
      await characterUseCase.favorite(character);
      // assert
      verify(() => mockCharacterRepository.favorite(character)).called(1);
    });

    test('should throw a failure', () async {
      // arrange
      when(() => mockCharacterRepository.favorite(any()))
          .thenThrow(ServerFailure());
      // act
      final call = characterUseCase.favorite;
      // assert
      expect(() => call(character), throwsA(isA<Failure>()));
    });
  });
}
