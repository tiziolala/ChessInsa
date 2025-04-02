import 'package:chess_insa/Piece.dart';


class Cavalier extends Piece{
  Cavalier(super.id,super.j);
  @override
  List mouvPossible(List<List<Piece>> echiquier){
    List deplacement = [];
    int x = getPosition()[0];
    int y = getPosition()[1];
    // haut et gauche
    if((x+2 < 8) && (0 <= y-1)){ // dans les limites
      if(echiquier[x+2][y-1].getJoueur() != getJoueur()){ // si la case ne contient pas une de nos piece
        deplacement += [x+2,y-1];
      }
    }
    // haut et droite
    if((x+2 < 8) && (y+1< 8)){ // dans les limites
      if(echiquier[x+2][y+1].getJoueur() != getJoueur()){ // si la case ne contient pas une de nos piece
        deplacement += [x+2,y+1];
      }
    }
    // droite et haut
    if((x+1 <8) && (y+2 < 8)){ // dans les limites
      if(echiquier[x+1][y+2].getJoueur() != getJoueur()){ // si la case ne contient pas une de nos piece
        deplacement += [x+1,y+2];
      }
    }
    // droite et bas
    if((0<= x-1) && (y+2<8)){ // dans les limites
      if(echiquier[x-1][y+2].getJoueur() != getJoueur()){ // si la case ne contient pas une de nos piece
        deplacement += [x-1,y+2];
      }
    }
    // bas et droite
    if((0<= x-2) && (y+1<8)){ // dans les limites
      if(echiquier[x-2][y+1].getJoueur() != getJoueur()){ // si la case ne contient pas une de nos piece
        deplacement += [x-2,y+1];
      }
    }
    // bas et gauche
    if((0<=x-2) && (0 <= y-1)){ // dans les limites
      if(echiquier[x-2][y-1].getJoueur() != getJoueur()){ // si la case ne contient pas une de nos piece
        deplacement += [x-2,y-1];
      }
    }
    // gauche et bas
    if((0<= x-1) && (0 <= y-2)){ // dans les limites
      if(echiquier[x-1][y-2].getJoueur() != getJoueur()){ // si la case ne contient pas une de nos piece
        deplacement += [x-1,y-2];
      }
    }
    // gauche et haut
    if((x+1 < 8) && (0 <= y-2)){ // dans les limites
      if(echiquier[x+1][y-2].getJoueur() != getJoueur()){ // si la case ne contient pas une de nos piece
        deplacement += [x+1,y-2];
      }
    }
    return deplacement;
  }
}