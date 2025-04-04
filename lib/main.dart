import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_wiki/data/sources/hive_names.dart';
import 'package:rick_and_morty_wiki/presentation/di/app_module.dart';
import 'package:rick_and_morty_wiki/presentation/di/color_schemes.dart';
import 'package:rick_and_morty_wiki/presentation/di/theme_provider.dart';
import 'package:rick_and_morty_wiki/presentation/screens/nav_bar_screen.dart';

import 'domain/entities/hive_character.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveCharacterAdapter());
  await Hive.openBox<HiveCharacter>(HiveBox.favorites);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeDates.lightTheme,
      darkTheme: ThemeDates.darkTheme,
      home: const NavBarScreen(),
    );
  }
}
