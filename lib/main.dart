import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ChessScreen(),
    );
  }
}

class ChessScreen extends StatelessWidget {
  const ChessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlayerName("Joueur 1", true),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/echiquier_crop.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildPlayerName("Joueur 2", false),
        ],
      ),
    );
  }

  Widget _buildPlayerName(String name, bool flip) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Transform(
        alignment: Alignment.center,
        transform: flip ? Matrix4.rotationX(3.1416) * Matrix4.rotationY(3.1416) : Matrix4.identity(),
        child: Text(
          name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
