import 'package:chess_insa/models/Piece.dart';


class Fou extends Piece{
  Fou(super.id,super.j);
  @override
  List mouvPossible(List<List<Piece>> echiquier){
    List deplacement = [];
    int x = getPosition()[0];
    int y = getPosition()[1];
    int i = 1;
    while((x+i < 8) && ((y+i)< 8)){ // dans les limites, diagonal supérieur droite
      if(echiquier[x+i][y+i].getJoueur() == 0){ // si la case est vide
          deplacement += [x+i,y+i];
        }
        else{if(echiquier[x+i][y+i].getJoueur() == 3 - getJoueur()){ // si la case est occupé par une piece ennemie
          deplacement += [x+i,y+i];
          break; // et on arrete la boucle
        }
        else{break;} // si la case est occupé par une de nos piece
        }
      i++;
    }
    i =1;
    while((x+i < 8) && (0 <= (y-i))){ // dans les limites, diagonal supérieur gauche
      if(echiquier[x+i][y-i].getJoueur() == 0){ // si la case est vide
          deplacement += [x+i,y-i];
        }
        else{if(echiquier[x+i][y-i].getJoueur() == 3 - getJoueur()){ // si la case est occupé par une piece ennemie
          deplacement += [x+i,y-i];
          break; // et on arrete la boucle
        }
        else{break;} // si la case est occupé par une de nos piece
        }
      i++;
    }
    i = 1;
    while((0 <=x-i) && ((y+i)< 8)){ // dans les limites, diagonal inferieur droite
      if(echiquier[x-i][y+i].getJoueur() == 0){ // si la case est vide
          deplacement += [x-i,y+i];
        }
        else{if(echiquier[x-i][y+i].getJoueur() == 3 - getJoueur()){ // si la case est occupé par une piece ennemie
          deplacement += [x-i,y+i];
          break; // et on arrete la boucle
        }
        else{break;} // si la case est occupé par une de nos piece
        }
      i++;
    }
    i=1;
    while((0 <=x-i) && (0 <= (y-i))){ // dans les limites, diagonal inferieur gauche
      if(echiquier[x-i][y-i].getJoueur() == 0){ // si la case est vide
          deplacement += [x-i,y-i];
        }
        else{if(echiquier[x-i][y-i].getJoueur() == 3 - getJoueur()){ // si la case est occupé par une piece ennemie
          deplacement += [x-i,y-i];
          break; // et on arrete la boucle
        }
        else{break;} // si la case est occupé par une de nos piece
        }
      i++;
    }
    return deplacement;
  }
}