import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/domain/repository/character_repository.dart';
import 'package:rick_and_morty/app/feature/characters/domain/use_case/character_usecase.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late MockCharacterRepository mockCharacterRepository;
  late CharacterUseCase characterUseCase;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    characterUseCase = CharacterUseCaseImpl(mockCharacterRepository);
  });

  group('list', () {
    test('should list characters', () async {
      // arrange
      when(() => mockCharacterRepository.listCharacters(any()))
          .thenAnswer((_) async => []);
      // act
      await characterUseCase.list(1);
      // assert
      verify(() => mockCharacterRepository.listCharacters(1)).called(1);
    });

    test('should throw a failure', () async {
      // arrange
      when(() => mockCharacterRepository.listCharacters(any()))
          .thenThrow(ServerFailure());
      // act
      final call = characterUseCase.list;
      // assert
      expect(() => call(1), throwsA(isA<Failure>()));
    });
  });

  group('searchByName', () {
    test('should search characters by name', () async {
      // arrange
      when(() => mockCharacterRepository.searchCharacterByName(any()))
          .thenAnswer((_) async => []);
      // act
      await characterUseCase.searchByName('Rick');
      // assert
      verify(() => mockCharacterRepository.searchCharacterByName('Rick'))
          .called(1);
    });

    test('should throw a failure', () async {
      // arrange
      when(() => mockCharacterRepository.searchCharacterByName(any()))
          .thenThrow(ServerFailure());
      // act
      final call = characterUseCase.searchByName;
      // assert
      expect(() => call('Rick'), throwsA(isA<Failure>()));
    });
  });
}
