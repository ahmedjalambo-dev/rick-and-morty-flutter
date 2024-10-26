import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/config/routes/route_generator.dart';

void main() {
  runApp(const MyApp());

  // Set the system UI mode to edge-to-edge,
  // making the navigation bar and status bar transparent
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        fontFamily: 'ComicNeue',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0e4046)),
        useMaterial3: false,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
