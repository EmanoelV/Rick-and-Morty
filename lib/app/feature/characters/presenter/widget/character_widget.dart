import 'package:flutter/material.dart';

import '../../domain/entity/character.dart';
import '../util/asset.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget(
    this.character, {
    required this.onFavorite,
    Key? key,
  }) : super(key: key);

  final Character character;
  final Function(Character) onFavorite;

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
        // add favorite button icon
        trailing: FavoriteButton(character: character, onFavorite: onFavorite),
      );
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.character,
    required this.onFavorite,
  }) : super(key: key);

  final Character character;
  final Function(Character p1) onFavorite;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(
          character.favorite ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: () => onFavorite(character),
      );
}
