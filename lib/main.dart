import 'package:flutter/material.dart';
import 'views/screens/home_screen.dart';

void main() {
  runApp(const ChessInsa());
}

class ChessInsa extends StatelessWidget {
  const ChessInsa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChessInsa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Définir HomeScreen comme écran de démarrage
      home: const HomeScreen(),
      // autres routes ()
      routes: {
      },
      debugShowCheckedModeBanner: false, // Retire la bannière "Debug"
    );
  }
}