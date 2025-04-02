import 'package:flutter/material.dart';

import '../models/Echiquier.dart';


class Game_screen extends StatefulWidget {
  final String p1Name;
  final String p2Name;
  final String p1Skin;
  final String p2Skin;
  final String boardstyle;
  final bool timer;
  final int initial_time;

  // Le constructeur prend les noms des joueurs en paramètres
  const Game_screen ({required this.p1Name, required this.p2Name, required this.p1Skin, required this.p2Skin, required this.boardstyle, required this.timer, this.initial_time=0});
  @override
  State<Game_screen> createState() => _Game_screenState();
}


class _Game_screenState extends State<Game_screen>{
  Echiquier game_table = Echiquier(1); // backend
  


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlayerName(widget.p1Name, true),
          // Affichage du temps restant
          Transform.rotate(
            angle: 3.1416 / 2,
            child: Text(
              'Temps restant: ${game_table.tempGestor[1].getTime()}s',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/echiquier_crop.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildPlayerName(widget.p2Name, false),
          Text(
            'Temps restant: ${game_table.tempGestor[1].getTime()}s',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
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