import 'package:chess_insa/models/Piece.dart';


class Vide extends Piece{ // Pour gérer les cases vides
  Vide():super(0,0); // id = 0 et joueur = 0 sera le repère pour savoir si la piece est Vide
  @override
  List mouvPossible(List<List<Piece>> echiquier){
    return [];
  }
}