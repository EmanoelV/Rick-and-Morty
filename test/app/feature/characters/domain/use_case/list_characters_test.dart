import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/feature/characters/domain/error/error.dart';
import 'package:rick_and_morty/app/feature/characters/domain/repository/character_repository.dart';
import 'package:rick_and_morty/app/feature/characters/domain/use_case/list_characters.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late ListCharacters useCase;
  late MockCharacterRepository repository;

  setUp(() {
    repository = MockCharacterRepository();
    useCase = ListCharactersImpl(repository);
  });

  test('should return a list of characters', () async {
    // arrange
    when(() => repository.listCharacters(any())).thenAnswer((_) async => []);
    // act
    final result = await useCase(1);
    // assert
    expect(result, []);
    verify(() => repository.listCharacters(1)).called(1);
  });

  test('should throw a ServerFailure when the call to the repository fails',
      () async {
    // arrange
    when(() => repository.listCharacters(any())).thenThrow(ServerFailure());
    // act
    final call = useCase.call;
    // assert
    expect(() => call(1), throwsA(isA<ServerFailure>()));
  });
}
