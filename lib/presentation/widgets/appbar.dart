import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/theme_provider.dart';

class Appbar extends AppBar {
  Appbar({super.key});

  static getAppBar() {
    return AppBar(
      actions: [
        Consumer(
          builder: (context, ref, child) {
            final theme = ref.watch(themeModeProvider);
            return IconButton(
              icon: Icon(
                theme == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () {
                ref.read(themeModeProvider.notifier).state =
                    theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
              },
            );
          },
        ),
      ],
      title: Image.asset('assets/images/RM_Logo.png', height: 60),
    );
  }
}
