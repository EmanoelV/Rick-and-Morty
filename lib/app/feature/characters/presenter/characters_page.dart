import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'characters_store.dart';
import 'widget/character_widget.dart';

class CharactersPage extends StatelessWidget {
  final CharactersStore store;

  const CharactersPage(this.store, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Characters'),
        ),
        body: Observer(
            builder: (context) => Center(
                  child: store.loading
                      ? const CircularProgressIndicator()
                      : store.hasError
                          ? ErrorWidget(store.error!)
                          : store.hasCharacters
                              ? ListView.builder(
                                  itemCount: store.characters.length,
                                  itemBuilder: (context, index) =>
                                      CharacterWidget(store.characters[index]),
                                )
                              : const Text('No characters'),
                )),
      );
}
