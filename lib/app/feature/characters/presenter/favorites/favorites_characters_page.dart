import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../widget/character_listview_widget.dart';
import 'favorites_characters_store.dart';

class FavoritesCharactersPage extends StatelessWidget {
  final FavoritesCharactersStore store;

  const FavoritesCharactersPage(this.store, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: Observer(
            builder: (context) => store.loading && !store.hasCharacters
                ? const Center(child: CircularProgressIndicator())
                : store.hasError
                    ? ErrorWidget(store.error!)
                    : store.hasCharacters
                        ? CharacterListView(
                            characters: store.characters,
                            onFavorite: store.favorite,
                            hasPagination: false,
                            loadMore: () => {},
                          )
                        : const Text('No favorites')),
      );
}
