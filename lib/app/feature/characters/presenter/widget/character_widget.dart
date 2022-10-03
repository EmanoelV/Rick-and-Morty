import 'package:flutter/material.dart';

import '../../domain/entity/character.dart';
import '../util/asset.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget(
    this.character, {
    Key? key,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => Navigator.of(context).pushNamed(
          '/detail',
          arguments: character,
        ),
        title: Text(character.name),
        subtitle: Text(character.specie),
        leading: Image.network(
          character.imageUrl,
          errorBuilder: (context, error, stackTrace) =>
              Image.asset(Asset.noProfileImage),
        ),
      );
}
