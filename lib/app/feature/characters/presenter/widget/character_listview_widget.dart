import 'package:flutter/material.dart';

import '../../domain/entity/character.dart';
import 'character_widget.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({
    required this.characters,
    required this.hasPagination,
    required this.loadMore,
    Key? key,
  }) : super(key: key);

  final List<Character> characters;
  final bool hasPagination;
  final Function() loadMore;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: characters.length + 1,
        itemBuilder: (context, index) {
          if (index == characters.length) {
            if (hasPagination) {
              loadMore();
              return const Center(child: LinearProgressIndicator());
            }
            return const SizedBox.shrink();
          }
          return CharacterWidget(characters[index]);
        },
      );
}
