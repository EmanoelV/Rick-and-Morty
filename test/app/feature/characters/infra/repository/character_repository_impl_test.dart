import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/infra/datasource/character_datasource.dart';
import 'package:rick_and_morty/app/feature/characters/infra/repository/character_repository_impl.dart';

class MockCharacterDatasource extends Mock implements CharacterDatasource {}

void main() {
  late CharacterRepositoryImpl repository;
  late MockCharacterDatasource datasource;

  setUp(() {
    datasource = MockCharacterDatasource();
    repository = CharacterRepositoryImpl(datasource);
  });

  group('listCharacters', () {
    test('should return a list of characters', () async {
      // arrange
      when(() => datasource.listCharacters(any())).thenAnswer((_) async => []);
      // act
      final result = await repository.listCharacters(1);
      // assert
      expect(result, []);
      verify(() => datasource.listCharacters(1)).called(1);
    });

    test('should throw a ServerFailure when the call to the repository fails',
        () async {
      // arrange
      when(() => datasource.listCharacters(any())).thenThrow(ServerFailure());
      // act
      final call = repository.listCharacters;
      // assert
      expect(() => call(1), throwsA(isA<ServerFailure>()));
    });
  });

  group('searchCharacterByName', () {
    test('should return a list of characters', () async {
      // arrange
      when(() => datasource.searchCharacterByName(any()))
          .thenAnswer((_) async => []);
      // act
      final result = await repository.searchCharacterByName('Rick');
      // assert
      expect(result, []);
      verify(() => datasource.searchCharacterByName('Rick')).called(1);
    });

    test('should throw a ServerFailure when the call to the repository fails',
        () async {
      // arrange
      when(() => datasource.searchCharacterByName(any()))
          .thenThrow(ServerFailure());
      // act
      final call = repository.searchCharacterByName;
      // assert
      expect(() => call('Rick'), throwsA(isA<ServerFailure>()));
    });
  });
}
