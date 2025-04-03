import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/api_state.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/character_cubit/character_cubit.dart';

import '../widgets/character_list_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Загружаем избранное при открытии экрана
    context.read<CharacterCubit>().loadFavorites();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Image.asset('assets/images/RM_Logo.png'),
              const SizedBox(height: 20),
              const Text(
                'Favorites',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<CharacterCubit, CharacterState>(
                  builder: (context, state) {
                    switch (state.getFavoritesState) {
                      case LoadingState _:
                        return const Center(child: CircularProgressIndicator());
                      case FailedState _:
                        return Center(child: Text('Error: ${state
                            .getFavoritesState.message}'));
                      case LoadedState _:
                        if (state.getFavoritesState.item!.isEmpty) {
                          return const Center(child: Text(
                              'No favorites found'));
                        }
                        return CharacterCardsListView(
                          scrollController: ScrollController(),
                          characters: state.getFavoritesState.item!,
                        );
                      default:
                        return const Center(child: Text('No favorites found'));
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
}