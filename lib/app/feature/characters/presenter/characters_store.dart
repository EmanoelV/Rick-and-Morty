import 'package:mobx/mobx.dart';

import '../domain/entity/character.dart';
import '../domain/error/error.dart';
import '../domain/use_case/character_usecase.dart';

part 'characters_store.g.dart';

class CharactersStore = CharactersStoreBase with _$CharactersStore;

abstract class CharactersStoreBase with Store {
  final CharacterUseCase _characterUseCase;

  CharactersStoreBase(this._characterUseCase) {
    listCharacters();
  }

  @observable
  ObservableList<Character> characters = <Character>[].asObservable();

  @observable
  bool loading = false;

  @observable
  Failure? error;

  @observable
  int page = 1;

  @observable
  bool pagination = true;

  @action
  void reset() {
    characters.clear();
    loading = false;
    error = null;
    page = 1;
  }

  Future<void> awaitLoading() async {
    while (loading) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @action
  Future<void> listCharacters() async {
    await awaitLoading();
    loading = true;
    error = null;
    try {
      final result = await _characterUseCase.list(page);
      characters.addAll(result);
      page++;
    } on Failure catch (e) {
      error = e;
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> searchCharactersByName(String name) async {
    reset();
    loading = true;
    error = null;
    try {
      final result = await _characterUseCase.searchByName(name);
      characters.addAll(result);
      pagination = false;
    } on Failure catch (e) {
      error = e;
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> clearFilter() async {
    reset();
    pagination = true;
    listCharacters();
  }

  @computed
  bool get hasError => error != null;

  @computed
  bool get hasCharacters => characters.isNotEmpty;
}
