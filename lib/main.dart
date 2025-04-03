import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_wiki/data/sources/hive_names.dart';
import 'package:rick_and_morty_wiki/presentation/di/app_module.dart';
import 'package:rick_and_morty_wiki/presentation/screens/nav_bar_screen.dart';

import 'domain/entities/hive_character.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveCharacterAdapter());
  await Hive.openBox<HiveCharacter>(HiveBox.favorites);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NavBarScreen(),
    );
  }
}
