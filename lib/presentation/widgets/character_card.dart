import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/character_cubit/character_cubit.dart';

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
              child: Stack(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: constraints.maxWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
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
                      ]),
                  _buildStatusPin(),
                  _buildFavoriteButton(context, character?.isFavorite ?? false),
                ],
              ),
            ),
          );
        }
    );
  }

  Positioned _buildFavoriteButton(BuildContext context, bool isFavorite) {
    return Positioned(bottom: 1,
      right: 1,
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.star : Icons.star_outline,
          color: Theme
              .of(context)
              .primaryColor,
          size: 35,
        ),
        onPressed: () {
          if (isFavorite) {
            context
                .read<CharacterCubit>()
                .removeFromFavourites(character!.id);
          } else {
            context
                .read<CharacterCubit>()
                .addToFavourites(character!);
          }

        },
      ),
    );
  }

  Positioned _buildStatusPin() {
    return Positioned(
      top: 5,
      right: 5,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: character?.status == 'Alive'
              ? Colors.green
              : Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          character?.status ?? 'STATUS',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
