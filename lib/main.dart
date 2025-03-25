import 'package:flutter/material.dart';

void main() {
  runApp(const ChessApp());
}

class ChessApp extends StatelessWidget {
  const ChessApp({super.key});

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
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlayerName("Joueur 1"),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/echiquier.jpg',
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),
          _buildPlayerName("Joueur 2"),
        ],
      ),
    );
  }

  Widget _buildPlayerName(String name) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        name,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
