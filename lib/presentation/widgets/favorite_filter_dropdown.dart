import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/character_cubit/character_cubit.dart';

class FavoriteFilterDropdown extends StatefulWidget {
  const FavoriteFilterDropdown({super.key});

  @override
  State<FavoriteFilterDropdown> createState() => _FavoriteFilterDropdownState();
}

class _FavoriteFilterDropdownState extends State<FavoriteFilterDropdown> {
  final List<(String, int)> _itemsList = [
    ('default', 1),
    ('name', 2),
    ('first the living', 3),
    ('first the dead', 4),
  ];
  (String, int)? _selectedItem;

  @override
  void initState() {
    _selectedItem = _itemsList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<(String, int)>(
      dropdownMenuEntries:
          _itemsList
              .map((item) => DropdownMenuEntry(label: item.$1, value: item))
              .toList(),
      initialSelection: _selectedItem,
      label: Text('Sort by'),
      onSelected: (value) {
        setState(() {
          _selectedItem = value;
          context.read<CharacterCubit>().loadFavorites(sortType: value?.$2);
        });
      },
    );
  }
}
