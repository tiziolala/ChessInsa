// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers pour les champs de texte
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();
  final TextEditingController _timerController = TextEditingController(text: '10');

  //Options pour les sets de pièces et style d'échiquier
  final List<String> _pieceSets = ['Classic', 'Wooden'];
  final List<String> _boardStyles = ['Classique', 'Wooden'];

  //Valeurs sélectionnées
  String _player1PieceSet = 'Classique';
  String _player2PieceSet = 'Classique';
  String _boardStyle = 'Classique';

  // État pour la checkbox du timer
  bool _useTimer = false;

    // Images de prévisualisation pour les styles
  final Map<String, String> _boardPreviewImages = {
    'Classique': 'assets/boards/classicBoard.png',
    'Bois': 'assets/boards/woodenBoard.png',
  };

    final Map<String, String> _piecePreviewImages = {
    'Classic': 'assets/pieces/classicKnight.png',
    'Wooden': 'assets/pieces/woodenKnight.png',
  };

  @override
  void dispose() {
    // Nettoyer les controllers quand la page est détruite
    _player1Controller.dispose();
    _player2Controller.dispose();
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChessInsa'),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Joueur 1
              const Center(
                child: Text(
                  'Joueur 1',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Pseudo :'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _player1PieceSet,
                    items: _pieceSets.map((String set) {
                      return DropdownMenuItem<String>(
                        value: set,
                        child: Text(set),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _player1PieceSet = value ?? 'Classic';
                      });
                    },
                  ),
                ),
              ),

              // Prévisualisation des pièces du joueur 1
              const SizedBox(height: 8),
              Container(
                height: 60,
                child: Center(
                  child: _buildPiecePreview(_player1PieceSet),
                ),
              ),

              const SizedBox(height: 24),
              
              // Joueur 2
              const Center(
                child: Text(
                  'Joueur 2',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Pseudo :'),
              const SizedBox(height: 8),
              TextField(
                controller: _player2Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Joueur 2',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Set de pièces :'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _player2PieceSet,
                    items: _pieceSets.map((String set) {
                      return DropdownMenuItem<String>(
                        value: set,
                        child: Text(set),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _player2PieceSet = value ?? 'Classic';
                      });
                    },
                  ),
                ),
              ),
              
              // Prévisualisation des pièces du joueur 2
              const SizedBox(height: 8),
              Container(
                height: 60,
                child: Center(
                  child: _buildPiecePreview(_player2PieceSet),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Echiquier
              const Text('Echiquier :'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _boardStyle,
                    items: _boardStyles.map((String style) {
                      return DropdownMenuItem<String>(
                        value: style,
                        child: Text(style),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _boardStyle = value ?? 'Classique';
                      });
                    },
                  ),
                ),
              ),
              
              // Prévisualisation de l'échiquier
              const SizedBox(height: 12),
              Container(
                height: 120,
                child: Center(
                  child: _buildBoardPreview(_boardStyle),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Option pour le timer
              Row(
                children: [
                  Checkbox(
                    value: _useTimer,
                    onChanged: (value) {
                      setState(() {
                        _useTimer = value ?? false;
                      });
                    },
                  ),
                  const Text('Jouer avec un Timer'),
                ],
              ),

              //Configurer le timer lorsque l'option est sélectionner
              if(_useTimer)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text('Temps par joueur (minutes) :'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _timerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        hintText: '10',
                      ),
                    ),
                  ],
                ),

              
              const SizedBox(height: 24),
              
              // Bouton pour démarrer la partie
              ElevatedButton(
                onPressed: () {
                  // Récupérer les valeurs et naviguer vers l'écran de jeu
                  final _p1Name = _player1Controller.text.isEmpty ? 'Joueur 1' : _player1Controller.text;
                  final _p2Name = _player2Controller.text.isEmpty ? 'Joueur 2' : _player2Controller.text;
                  int timerDuration = 42; //valeur par défaut

                  //conversion de la durée du timer
                  if (_useTimer) {
                    try {
                      timerDuration = int.parse(_timerController.text);
                    } catch (e) {
                      //si la conversion ne fonctionne pas on utilisera la valeur par défaut
                    }  
                  }

                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game_screen(
                        p1Name: _p1Name,
                        p2Name: _p2Name,
                        p1Skin: player1Skin,
                        p2Skin: player2Skin,
                        boardStyle: boardStyle,
                        useTimer: _useTimer,
                      ),
                    ),
                  );*/
                  print('Démarrer partie avec: $_p1Name, $_p2Name, Timer: $_useTimer');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Jouer', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Méthode pour construire la prévisualisation des pièces
  Widget _buildPiecePreview(String pieceSet) {
    // Dans une application réelle, utilisez vos propres assets
    // Pour l'exemple, nous utilisons un placeholder avec texte
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPieceIcon(pieceSet, 'K', Colors.black),
        _buildPieceIcon(pieceSet, 'Q', Colors.black),
        _buildPieceIcon(pieceSet, 'R', Colors.black),
        _buildPieceIcon(pieceSet, 'B', Colors.black),
        _buildPieceIcon(pieceSet, 'N', Colors.black),
        _buildPieceIcon(pieceSet, 'P', Colors.black),
      ],
    );
    
    // Avec de vrais assets, utilisez plutôt ceci:
    // return Image.asset(_piecePreviewImages[pieceSet] ?? 'assets/pieces/classic.png', height: 60);
  }
  
  // Helper pour construire une icône de pièce (version placeholder)
  Widget _buildPieceIcon(String style, String symbol, Color color) {
    Color bgColor;
    switch (style) {
      case 'Classic':
        bgColor = Colors.grey[300]!;
        break;
      case 'Wooden':
        bgColor = Colors.brown[300]!;
        break;
      case 'Modern':
        bgColor = Colors.blue[300]!;
        break;
      case 'Pixel':
        bgColor = Colors.purple[300]!;
        break;
      case 'Metallic':
        bgColor = Colors.grey[400]!;
        break;
      default:
        bgColor = Colors.grey[300]!;
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black45),
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  
  // Méthode pour construire la prévisualisation de l'échiquier
  Widget _buildBoardPreview(String boardStyle) {
    // Dans une application réelle, utilisez vos propres assets
    // Pour l'exemple, nous créons un mini-échiquier
    
    // Déterminer les couleurs en fonction du style
    Color lightSquare;
    Color darkSquare;
    
    switch (boardStyle) {
      case 'Classique':
        lightSquare = Colors.white;
        darkSquare = Colors.grey[700]!;
        break;
      case 'Bois':
        lightSquare = Colors.brown[200]!;
        darkSquare = Colors.brown[800]!;
        break;
      case 'Marbre':
        lightSquare = Colors.grey[100]!;
        darkSquare = Colors.grey[500]!;
        break;
      case 'Bleu':
        lightSquare = Colors.blue[100]!;
        darkSquare = Colors.blue[800]!;
        break;
      case 'Vert':
        lightSquare = Colors.green[100]!;
        darkSquare = Colors.green[800]!;
        break;
      default:
        lightSquare = Colors.white;
        darkSquare = Colors.grey[700]!;
    }
    
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: 16,
        itemBuilder: (context, index) {
          int row = index ~/ 4;
          int col = index % 4;
          bool isLightSquare = (row + col) % 2 == 0;
          
          return Container(
            color: isLightSquare ? lightSquare : darkSquare,
          );
        },
      ),
    );
    
    // Avec de vrais assets, utilisez plutôt ceci:
    // return Image.asset(_boardPreviewImages[boardStyle] ?? 'assets/boards/classic.png', height: 120);
  }
}

