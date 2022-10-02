import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'characters_store.dart';
import 'widget/character_listview_widget.dart';

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
                    SearchByNameWidget(store),
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

class SearchByNameWidget extends StatelessWidget {
  SearchByNameWidget(
    this.store, {
    Key? key,
  }) : super(key: key);

  final searchController = TextEditingController();
  final CharactersStore store;

  @override
  Widget build(BuildContext context) => TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search By Name',
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SearchByTextButtonWidget(
                  store: store, searchController: searchController),
              ResetFilterButtonWidget(
                  searchController: searchController, store: store),
            ],
          ),
        ),
      );
}

class ResetFilterButtonWidget extends StatelessWidget {
  const ResetFilterButtonWidget({
    Key? key,
    required this.searchController,
    required this.store,
  }) : super(key: key);

  final TextEditingController searchController;
  final CharactersStore store;

  @override
  Widget build(BuildContext context) => IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        searchController.clear();
        store.clearFilter();
      });
}

class SearchByTextButtonWidget extends StatelessWidget {
  const SearchByTextButtonWidget({
    Key? key,
    required this.store,
    required this.searchController,
  }) : super(key: key);

  final CharactersStore store;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) => IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => store.searchCharactersByName(searchController.text));
}
