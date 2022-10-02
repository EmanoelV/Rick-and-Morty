// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharactersStore on CharactersStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: 'CharactersStoreBase.hasError'))
          .value;
  Computed<bool>? _$hasCharactersComputed;

  @override
  bool get hasCharacters =>
      (_$hasCharactersComputed ??= Computed<bool>(() => super.hasCharacters,
              name: 'CharactersStoreBase.hasCharacters'))
          .value;

  late final _$charactersAtom =
      Atom(name: 'CharactersStoreBase.characters', context: context);

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
      Atom(name: 'CharactersStoreBase.loading', context: context);

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
      Atom(name: 'CharactersStoreBase.error', context: context);

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

  late final _$pageAtom =
      Atom(name: 'CharactersStoreBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$paginationAtom =
      Atom(name: 'CharactersStoreBase.pagination', context: context);

  @override
  bool get pagination {
    _$paginationAtom.reportRead();
    return super.pagination;
  }

  @override
  set pagination(bool value) {
    _$paginationAtom.reportWrite(value, super.pagination, () {
      super.pagination = value;
    });
  }

  late final _$listCharactersAsyncAction =
      AsyncAction('CharactersStoreBase.listCharacters', context: context);

  @override
  Future<void> listCharacters() {
    return _$listCharactersAsyncAction.run(() => super.listCharacters());
  }

  late final _$searchCharactersByNameAsyncAction = AsyncAction(
      'CharactersStoreBase.searchCharactersByName',
      context: context);

  @override
  Future<void> searchCharactersByName(String name) {
    return _$searchCharactersByNameAsyncAction
        .run(() => super.searchCharactersByName(name));
  }

  late final _$clearFilterAsyncAction =
      AsyncAction('CharactersStoreBase.clearFilter', context: context);

  @override
  Future<void> clearFilter() {
    return _$clearFilterAsyncAction.run(() => super.clearFilter());
  }

  late final _$CharactersStoreBaseActionController =
      ActionController(name: 'CharactersStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$CharactersStoreBaseActionController.startAction(
        name: 'CharactersStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$CharactersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
characters: ${characters},
loading: ${loading},
error: ${error},
page: ${page},
pagination: ${pagination},
hasError: ${hasError},
hasCharacters: ${hasCharacters}
    ''';
  }
}
