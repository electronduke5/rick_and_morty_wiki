import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_wiki/presentation/di/app_module.dart';
import 'package:rick_and_morty_wiki/presentation/screens/nav_bar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  await Hive.initFlutter();
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
      home: const NavBarScreen(),
    );
  }
}
