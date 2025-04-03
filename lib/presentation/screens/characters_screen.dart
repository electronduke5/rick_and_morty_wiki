import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/api_state.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/character_cubit/character_cubit.dart';
import 'package:rick_and_morty_wiki/presentation/widgets/character_card.dart';


class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Image.asset('assets/images/RM_Logo.png'),
              Expanded(
                child: BlocBuilder<CharacterCubit, CharacterState>(
                  builder: (context, state) {
                    switch (state.getCharactersState) {
                      case IdleState _:
                        return const Center(child: CircularProgressIndicator());
                      case LoadingState _:
                        return const Center(child: CircularProgressIndicator());
                      case FailedState _:
                        return Center(child: Text(state.getCharactersState
                            .message ?? 'Error'));
                      case LoadedState _ :
                        return _buildCharacterListView(state);
                      default:
                        return Text(
                            state.getCharactersState.message ??
                                'default: ${state.getCharactersState}');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildCharacterListView(CharacterState state) {
    return ListView.builder(
      itemCount: (state.getCharactersState.item!.length / 2)
          .ceil(),
      itemBuilder: (context, rowIndex) {
        final firstItemIndex = rowIndex * 2;
        final secondItemIndex = firstItemIndex + 1;
        return Row(
          children: [
            Expanded(
              child: CharacterCard(state.getCharactersState
                  .item?[firstItemIndex],),
            ),

            if (secondItemIndex <
                state.getCharactersState.item!.length)
              Expanded(
                child: CharacterCard(
                  state.getCharactersState
                      .item?[secondItemIndex],
                ),
              ),
          ],
        );
      },
    );
  }
}
