import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 300,
          width: 150,
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                  ),
                ),
                Text('Toxic Rick'),
                Text('Dead'),
                Text('Rick\'s Toxic Side'),
              ],
            ),
          ),
        );
      },
    );
  }
}
