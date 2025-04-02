import 'package:chess_insa/Piece.dart';


class Pion extends Piece{
  Pion(super.id,super.j);

  bool promotion(){
    if(joueur == 1){ // pion blanc
      if(position[0] == 7){ // est arrivé au bout
        return true;
      }
    }
    if(joueur == 2){ // pion noir
      if(position[0] == 0){ // est arrivé au bout
        return true;
      }
    }
    return false;
  }
  @override
  List mouvPossible(List<List<Piece>> echiquier){
    List deplacement = [];
    if(joueur == 1){ // pour les blancs
      if(echiquier[position[0]+1][position[1]].getJoueur() == 0){ // case suivante est libre
        if(position[0]+1 < 8){ // dans les limites
          deplacement += [[position[0]+1,position[1]]]; // ajout à la liste
        }
      }
      if(doubleAdvance()){ // si c'est le premier mouv du pion
      // on ne teste pas la limite du plateau à cause des conditions du doubleAdvance
        if(echiquier[position[0]+2][position[1]].getJoueur() == 0){ // et que la case est libre
          deplacement += [[position[0]+2,position[1]]]; // ajout à la liste
        }
      } // manger au dessus à droite
      if((0 <=position[0]+1) && (position[0]+1 < 8) && (0 <= (position[1]+1)) && ((position[1]+1)< 8)){ // gestion des bordure
        if(echiquier[position[0]+1][position[1]+1].getJoueur() == 2){ // et que la case est libre
          deplacement += [[position[0]+1,position[1]+1]]; // ajout à la liste
        }
      } // manger au dessus à gauche
      if((0 <=position[0]+1) && (position[0]+1 < 8) && (0 <= (position[1]-1)) && ((position[1]-1)< 8)){ // gestion des bordure
        if(echiquier[position[0]+1][position[1]-1].getJoueur() == 2){ // et que la case est libre
          deplacement += [[position[0]+1,position[1]-1]]; // ajout à la liste
        }
      }
    }
    if(joueur == 2){
      if(echiquier[position[0]-1][position[1]].getJoueur() == 0){ // case suivante est libre
        if(position[0]+1 < 8){ // dans les limites
          deplacement += [[position[0]-1,position[1]]];// ajout à la liste
        }
      }
      if(doubleAdvance()){ // si c'est le premier mouv du pion
      // on ne teste pas la limite du plateau à cause des conditions du doubleAdvance
        if(echiquier[position[0]-2][position[1]].getJoueur() == 0){ // et que la case est libre
          deplacement += [[position[0]-2,position[1]]]; // ajout à la liste
        }
      } // manger en dessous à droite
      if((0 <=position[0]-1) && (position[0]-1 < 8) && (0 <= (position[1]+1)) && ((position[1]+1)< 8)){ // gestion des bordure
        if(echiquier[position[0]-1][position[1]+1].getJoueur() == 1){ // et que la case est libre
          deplacement += [[position[0]-1,position[1]+1]]; // ajout à la liste
        }
      } // manger en dessous à gauche
      if((0 <=position[0]-1) && (position[0]-1 < 8) && (0 <= (position[1]-1)) && ((position[1]-1)< 8)){ // gestion des bordure
        if(echiquier[position[0]-1][position[1]-1].getJoueur() == 1){ // et que la case est libre
          deplacement += [[position[0]-1,position[1]-1]]; // ajout à la liste
        }
      }
    }
    return deplacement;
  }
  bool doubleAdvance(){
    if(joueur == 1){ //blanc
      if(position[0] == 1){ //position initial
        return true;
      }
    }
    if(joueur == 2){// noir
      if(position[0] == 6){ // position initial
        return true;
      }
    }
    return false;
  }
}