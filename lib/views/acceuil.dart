import 'package:flutter/material.dart';
import 'package:chess_insa/views/game_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'accueil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: player1Controller,
              decoration: InputDecoration(labelText: 'Nom du Joueur 1'),
            ),
            TextField(
              controller: player2Controller,
              decoration: InputDecoration(labelText: 'Nom du Joueur 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Récupérer les noms des joueurs et les passer à la page de jeu
                String player1Name = player1Controller.text;
                String player2Name = player2Controller.text;

                // Naviguer vers la page de jeu et passer les noms des joueurs
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Game_screen(
                      p1Name: player1Name,
                      p2Name: player2Name, 
                      timer: false,
                    ),
                  ),
                );
              },
              child: Text('Commencer le jeu'),
            ),
          ],
        ),
      ),
    );
  }
}
