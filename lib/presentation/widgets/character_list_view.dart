import 'package:flutter/material.dart';

import '../../data/models/character.dart';
import 'character_card.dart';

class CharacterCardsListView extends StatelessWidget {
  const CharacterCardsListView({
    super.key,
    required ScrollController scrollController,
    required this.characters,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: (characters.length / 2).ceil(),
      itemBuilder: (context, rowIndex) {
        final firstItemIndex = rowIndex * 2;
        final secondItemIndex = firstItemIndex + 1;
        return Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.474,
              child: CharacterCard(characters[firstItemIndex]),
            ),
            if (secondItemIndex < characters.length)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.474,
                child: CharacterCard(characters[secondItemIndex]),
              ),
          ],
        );
      },
    );
  }
}
