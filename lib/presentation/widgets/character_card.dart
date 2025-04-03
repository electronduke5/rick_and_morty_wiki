import 'package:flutter/material.dart';

import '../../data/models/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {super.key});

  final Character? character;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxWidth * 4 / 3 + 30,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: constraints.maxWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(
                          character?.image ??
                              'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      character?.name ?? 'NAME',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                    child: Text(character?.gender ?? 'GENDER'),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
