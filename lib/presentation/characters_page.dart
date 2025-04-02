import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/presentation/widgets/character_card.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('asdasd'),
              Image.asset('assets/images/RM_Logo.png'),
              Expanded (child: CharacterCard()),
              //Expanded(child: CharactersPage()),
            ],
          ),
        ),
      ),
    );
  }
}
