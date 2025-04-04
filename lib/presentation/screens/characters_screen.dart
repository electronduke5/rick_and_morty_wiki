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
  late int page;

  @override
  void initState() {
    super.initState();
    page = context
        .read<CharacterCubit>()
        .state
        .page;
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() async {
    if (_scrollController.position.extentAfter < 500 && !_isLoading) {
      setState(() => _isLoading = true);
      await context.read<CharacterCubit>().setPage(page++);
      try {
        await context.read<CharacterCubit>().loadAllCharacters(page: page);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка загрузки: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
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

