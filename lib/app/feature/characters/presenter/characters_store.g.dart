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

  late final _$listCharactersAsyncAction =
      AsyncAction('CharactersStoreBase.listCharacters', context: context);

  @override
  Future<void> listCharacters(int page) {
    return _$listCharactersAsyncAction.run(() => super.listCharacters(page));
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
hasError: ${hasError},
hasCharacters: ${hasCharacters}
    ''';
  }
}
