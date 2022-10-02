import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../domain/entity/character.dart';
import '../domain/error/error.dart';
import '../domain/use_case/character_usecase.dart';

part 'characters_store.g.dart';

class CharactersStore = CharactersStoreBase with _$CharactersStore;

abstract class CharactersStoreBase with Store {
  final CharacterUseCase _characterUseCase;
  final TextEditingController searchController = TextEditingController();

  CharactersStoreBase(this._characterUseCase) {
    listCharacters();
  }

  @observable
  ObservableList<Character> characters = <Character>[].asObservable();

  @observable
  Specie specie = Specie.all;

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
    pagination = true;
    searchController.clear();
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
      final result = await _characterUseCase.list(page, specie.textKey);
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
    searchController.text = name;
    loading = true;
    error = null;
    try {
      final result = await _characterUseCase.searchByName(name, specie.textKey);
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
    specie = Specie.all;
    listCharacters();
  }

  @action
  Future<void> filterBySpecie(Specie? specie) async {
    final name = searchController.text;
    this.specie = specie ?? Specie.all;
    if (name.isEmpty) {
      reset();
      listCharacters();
    } else {
      searchCharactersByName(name);
    }
  }

  @computed
  bool get hasError => error != null;

  @computed
  bool get hasCharacters => characters.isNotEmpty;
}

enum Specie { human, alien, all }

extension SpecieExtension on Specie {
  String get textKey {
    switch (this) {
      case Specie.human:
        return 'human';
      case Specie.alien:
        return 'alien';
      case Specie.all:
        return '';
    }
  }

  String get text {
    switch (this) {
      case Specie.human:
        return 'Human';
      case Specie.alien:
        return 'Alien';
      case Specie.all:
        return 'All';
    }
  }
}
