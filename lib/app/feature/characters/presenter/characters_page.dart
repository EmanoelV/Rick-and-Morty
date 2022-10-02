import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'characters_store.dart';
import 'widget/character_listview_widget.dart';
import 'widget/search_by_name_widget.dart';
import 'widget/specie_filter_widget.dart';

class CharactersPage extends StatelessWidget {
  final CharactersStore store;

  const CharactersPage(this.store, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Characters'),
        ),
        body: Observer(
            builder: (context) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: SearchByNameWidget(store),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: SpecieFilterWidget(store),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: store.loading && !store.hasCharacters
                          ? const Center(child: CircularProgressIndicator())
                          : store.hasError
                              ? ErrorWidget(store.error!)
                              : store.hasCharacters
                                  ? CharacterListView(
                                      characters: store.characters,
                                      hasPagination: store.pagination,
                                      loadMore: store.listCharacters,
                                    )
                                  : const Text('No characters'),
                    ),
                  ],
                )),
      );
}
