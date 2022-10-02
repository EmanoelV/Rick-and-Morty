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
        title: Text(character.name),
        leading: Image.network(character.imageUrl,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset(Asset.noProfileImage)),
      );
}
