// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_characters_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesCharactersStore on FavoritesCharactersStoreBase, Store {
  Computed<bool>? _$hasCharactersComputed;

  @override
  bool get hasCharacters =>
      (_$hasCharactersComputed ??= Computed<bool>(() => super.hasCharacters,
              name: 'FavoritesCharactersStoreBase.hasCharacters'))
          .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: 'FavoritesCharactersStoreBase.hasError'))
          .value;

  late final _$charactersAtom =
      Atom(name: 'FavoritesCharactersStoreBase.characters', context: context);

  @override
  ObservableList<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'FavoritesCharactersStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'FavoritesCharactersStoreBase.error', context: context);

  @override
  Failure? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Failure? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$listCharactersAsyncAction = AsyncAction(
      'FavoritesCharactersStoreBase.listCharacters',
      context: context);

  @override
  Future<void> listCharacters() {
    return _$listCharactersAsyncAction.run(() => super.listCharacters());
  }

  late final _$favoriteAsyncAction =
      AsyncAction('FavoritesCharactersStoreBase.favorite', context: context);

  @override
  Future<void> favorite(Character character) {
    return _$favoriteAsyncAction.run(() => super.favorite(character));
  }

  late final _$FavoritesCharactersStoreBaseActionController =
      ActionController(name: 'FavoritesCharactersStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$FavoritesCharactersStoreBaseActionController
        .startAction(name: 'FavoritesCharactersStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$FavoritesCharactersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
characters: ${characters},
loading: ${loading},
error: ${error},
hasCharacters: ${hasCharacters},
hasError: ${hasError}
    ''';
  }
}
