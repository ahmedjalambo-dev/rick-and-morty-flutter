import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/config/routes/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      theme: ThemeData(
        fontFamily: 'LemonMilk',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff272b33),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
