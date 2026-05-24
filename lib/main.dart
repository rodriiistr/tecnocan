import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

// IMPORTS DE DRIFT
import 'data/app_database.dart';
import 'data/database_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();

  runApp(
    DatabaseProvider(
      db: db,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        fontFamily: "Montserrat",
      ),
      home: SplashScreen(),
    );
  }
}