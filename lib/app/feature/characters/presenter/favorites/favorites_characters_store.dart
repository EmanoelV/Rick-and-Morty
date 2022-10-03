import 'package:mobx/mobx.dart';

import '../../domain/entity/character.dart';
import '../../domain/error/error.dart';
import '../../domain/use_case/character_usecase.dart';

part 'favorites_characters_store.g.dart';

class FavoritesCharactersStore = FavoritesCharactersStoreBase
    with _$FavoritesCharactersStore;

abstract class FavoritesCharactersStoreBase with Store {
  final CharacterUseCase _characterUseCase;

  FavoritesCharactersStoreBase(this._characterUseCase) {
    listCharacters();
  }

  @observable
  ObservableList<Character> characters = <Character>[].asObservable();

  @observable
  bool loading = false;

  @observable
  Failure? error;

  @action
  void reset() {
    characters.clear();
    loading = false;
    error = null;
  }

  @action
  Future<void> listCharacters() async {
    reset();
    characters = (await _characterUseCase.getFavorites()).asObservable();
  }

  @action
  Future<void> favorite(Character character) async {
    await _characterUseCase.favorite(character);
    listCharacters();
  }

  @computed
  bool get hasCharacters => characters.isNotEmpty;

  @computed
  bool get hasError => error != null;
}
