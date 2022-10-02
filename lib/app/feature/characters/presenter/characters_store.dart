import 'package:mobx/mobx.dart';

import '../domain/entity/character.dart';
import '../domain/error/error.dart';
import '../domain/use_case/list_characters.dart';

part 'characters_store.g.dart';

class CharactersStore = CharactersStoreBase with _$CharactersStore;

abstract class CharactersStoreBase with Store {
  final ListCharacters _listCharacters;

  CharactersStoreBase(this._listCharacters) {
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

  @action
  void reset() {
    characters.clear();
    loading = false;
    error = null;
  }

  @action
  Future<void> listCharacters() async {
    loading = true;
    error = null;
    try {
      final result = await _listCharacters(page);
      characters.addAll(result);
      page++;
    } on Failure catch (e) {
      error = e;
    } finally {
      loading = false;
    }
  }

  @computed
  bool get hasError => error != null;

  @computed
  bool get hasCharacters => characters.isNotEmpty;
}
