import 'package:flutter/material.dart';

import '../../domain/entity/character.dart';
import '../util/asset.dart';

class DetailCharacterPage extends StatelessWidget {
  const DetailCharacterPage(this.character, {super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final createdDateFormatted =
        '${character.created.day}/${character.created.month}/${character.created.year}';
    return Scaffold(
        appBar: AppBar(
          title: Text(character.name),
        ),
        body: Column(
          children: [
            Image.network(
              character.imageUrl,
              fit: BoxFit.fitWidth,
              height: 300,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                Asset.noProfileImage,
                fit: BoxFit.fitWidth,
                height: 300,
                width: double.infinity,
              ),
            ),
            ListTile(
              title: const Text('Specie'),
              subtitle: Text(character.specie),
            ),
            ListTile(
              title: const Text('Status'),
              subtitle: Text(character.status),
            ),
            ListTile(
              title: const Text('Created'),
              subtitle: Text(createdDateFormatted),
            ),
            Flexible(
              child: ListTile(
                title: const Text('Episodes'),
                subtitle: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: character.episodes.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child: Text(character.episodes[index].toString()),
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ));
  }
}
