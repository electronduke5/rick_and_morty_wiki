import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/presentation/characters_page.dart';
import 'package:rick_and_morty_wiki/presentation/di/app_module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CharactersPage(),
    );
  }
}
