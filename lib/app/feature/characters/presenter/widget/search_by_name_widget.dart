import 'package:flutter/material.dart';

import '../characters_store.dart';

class SearchByNameWidget extends StatelessWidget {
  const SearchByNameWidget(
    this.store, {
    Key? key,
  }) : super(key: key);
  final CharactersStore store;

  @override
  Widget build(BuildContext context) => TextField(
        controller: store.searchController,
        decoration: InputDecoration(
          hintText: 'Search By Name',
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SearchByTextButtonWidget(
                searchByText: store.searchCharactersByName,
                searchController: store.searchController,
              ),
              ResetFilterButtonWidget(store.clearFilter),
            ],
          ),
        ),
      );
}

class ResetFilterButtonWidget extends StatelessWidget {
  const ResetFilterButtonWidget(
    this.clearFilter, {
    Key? key,
  }) : super(key: key);

  final Function() clearFilter;

  @override
  Widget build(BuildContext context) =>
      IconButton(icon: const Icon(Icons.clear), onPressed: clearFilter);
}

class SearchByTextButtonWidget extends StatelessWidget {
  const SearchByTextButtonWidget({
    required this.searchByText,
    required this.searchController,
    Key? key,
  }) : super(key: key);

  final Function(String) searchByText;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => searchByText(searchController.text),
      );
}
