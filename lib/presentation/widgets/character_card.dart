import 'package:flutter/material.dart';

import '../../data/models/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {super.key});

  final Character? character;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 150,
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                character?.image ??
                    'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
              ),
            ),
            Text(character?.name ?? 'NAME'),
            Text(character?.gender ?? 'GENDER'),
            Text(character?.status ?? 'STATUS'),
          ],
        ),
      ),
    );
  }
}
