import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/entity/character.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/infra/datasource/character_datasource.dart';
import 'package:rick_and_morty/app/feature/characters/infra/model/character_model.dart';
import 'package:rick_and_morty/app/feature/characters/infra/repository/character_repository_impl.dart';

class MockCharacterDatasource extends Mock implements CharacterDatasource {}

void main() {
  late CharacterRepositoryImpl repository;
  late MockCharacterDatasource datasource;
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
    datasource = MockCharacterDatasource();
    repository = CharacterRepositoryImpl(datasource);
    registerFallbackValue(character);
    registerFallbackValue(CharacterModel.fromEntity(character));
  });

  group('listCharacters', () {
    test('should return a list of characters', () async {
      // arrange
      when(() => datasource.listCharacters(any(), ''))
          .thenAnswer((_) async => []);
      // act
      final result = await repository.listCharacters(1, '');
      // assert
      expect(result, []);
      verify(() => datasource.listCharacters(1, '')).called(1);
    });

    test('should throw a ServerFailure when the call to the repository fails',
        () async {
      // arrange
      when(() => datasource.listCharacters(any(), ''))
          .thenThrow(ServerFailure());
      // act
      final call = repository.listCharacters;
      // assert
      expect(() => call(1, ''), throwsA(isA<ServerFailure>()));
    });
  });

  group('searchCharacterByName', () {
    test('should return a list of characters', () async {
      // arrange
      when(() => datasource.searchCharacterByName(any(), ''))
          .thenAnswer((_) async => []);
      // act
      final result = await repository.searchCharacterByName('Rick', '');
      // assert
      expect(result, []);
      verify(() => datasource.searchCharacterByName('Rick', '')).called(1);
    });

    test('should throw a ServerFailure when the call to the repository fails',
        () async {
      // arrange
      when(() => datasource.searchCharacterByName(any(), any()))
          .thenThrow(ServerFailure());
      // act
      final call = repository.searchCharacterByName;
      // assert
      expect(() => call('Rick', ''), throwsA(isA<ServerFailure>()));
    });
  });

  group('favorite', () {
    test('should call datasource', () async {
      // arrange
      when(() => datasource.favorite(any())).thenAnswer((_) async => true);
      // act
      await repository.favorite(character);
      // assert
      verify(() => datasource.favorite(any())).called(1);
    });

    test('should throw a ServerFailure when the call to the repository fails',
        () async {
      // arrange
      when(() => datasource.favorite(any())).thenThrow(ServerFailure());
      // act
      final call = repository.favorite;
      // assert
      expect(() => call(character), throwsA(isA<ServerFailure>()));
    });
  });
}
