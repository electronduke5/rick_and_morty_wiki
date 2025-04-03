import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/api_state.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/character_cubit/character_cubit.dart';

import '../widgets/character_list_view.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();

  bool _isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent && !_isLoading) {
      _isLoading = true;
      page++;
      context.read<CharacterCubit>().loadAllCharacters(page: page);
      _isLoading = false;
    }
  }

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
                    final currentState = state.getCharactersState;

                    if (currentState is LoadingState && page == 1) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final characters = currentState is PartiallyLoadedState
                        ? currentState.item
                        : (currentState is LoadedState ? currentState.item : [
                    ]);

                    if (characters!.isEmpty && currentState is! LoadingState) {
                      return const Center(child: Text('No characters found'));
                    }
                    return Stack(
                      children: [
                        CharacterCardsListView(
                          scrollController: _scrollController,
                          characters: state.getCharactersState.item!,
                        ),
                        if (currentState is PartiallyLoadedState)
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    );
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

