import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../characters_store.dart';

class SpecieFilterWidget extends StatelessWidget {
  const SpecieFilterWidget(
    this.store, {
    Key? key,
  }) : super(key: key);

  final CharactersStore store;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          // buttons to filter by specie
          SpecieFilterButton(
            store,
            specie: Specie.all,
          ),
          const SizedBox(
            width: 10,
          ),
          SpecieFilterButton(
            store,
            specie: Specie.human,
          ),
          const SizedBox(
            width: 10,
          ),
          SpecieFilterButton(
            store,
            specie: Specie.alien,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      );
}

class SpecieFilterButton extends StatelessWidget {
  const SpecieFilterButton(
    this.store, {
    Key? key,
    required this.specie,
  }) : super(key: key);

  final CharactersStore store;
  final Specie specie;

  @override
  Widget build(BuildContext context) => Observer(
      builder: (context) => ElevatedButton(
            onPressed: () => store.filterBySpecie(specie),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  // get theme colors
                  store.specie == specie
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
            ),
            child: Text(specie.text),
          ));
}
