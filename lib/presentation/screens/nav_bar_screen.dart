import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/character_cubit/character_cubit.dart';

import '../widgets/nav_bar_item.dart';
import 'characters_screen.dart';
import 'favorites_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child:
                _currentIndex == 0
                    ? BlocProvider<CharacterCubit>(
                      create:
                          (context) => CharacterCubit()..loadAllCharacters(),
                  child: CharactersScreen(key: ValueKey('characters'),),
                    )
                    : BlocProvider<CharacterCubit>(
                  create:
                      (context) =>
                  CharacterCubit(),
                  child: FavoritesScreen(key: ValueKey('favorites'),
                  ),
                ),

            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 1,
            child: _buildFancyNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFancyNavBar() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarItem(
              icon: Icons.people_outline,
              activeIcon: Icons.people,
              label: 'Персонажи',
              isActive: _currentIndex == 0,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            NavBarItem(
              icon: Icons.star_outline,
              activeIcon: Icons.star,
              label: 'Избранное',
              isActive: _currentIndex == 1,
              onTap: () => setState(() => _currentIndex = 1),
            ),
          ],
        ),
      ),
    );
  }
}
