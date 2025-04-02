import 'package:chess_insa/Piece.dart';


class Reine extends Piece{
  Reine(super.id,super.j);
  @override
  List mouvPossible(List<List<Piece>> echiquier){
    List deplacement = [];
    int x = getPosition()[0];
    int y = getPosition()[1];
    int i = 1;
    
    // diagonal
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
    // droite
    i = getPosition()[0];
    int j = getPosition()[1];
    // l'avantage de la tour, c'est que son déplacement est symétrique par rapport à l'axe x, donc indépendant du joueur
    while(++i < 8){ // vers le haut, dans les bordures
      if(echiquier[i][j].getJoueur() == 0){ // si la case est vide
        deplacement += [i,j];
      }
      else{if(echiquier[i][j].getJoueur() == 3 - getJoueur()){ //si la case contient une piece ennemie
        deplacement += [i,j];
        break; // et on arrete la boucle
      }
      else{break;} // si la case contient une de nos piece, on arrete la boucle
      }
    }
    i = getPosition()[0];
    while(0 <= --i){ // vers le bas
      if(echiquier[i][j].getJoueur() == 0){
        deplacement += [i,j];
      }
      else{if(echiquier[i][j].getJoueur() == 3 - getJoueur()){
        deplacement += [i,j];
        break;
      }
      else{break;}
      }
    }
    i = getPosition()[0];
    while(++j < 8){ // vers la droite 
      if(echiquier[i][j].getJoueur() == 0){
        deplacement += [i,j];
      }
      else{if(echiquier[i][j].getJoueur() == 3 - getJoueur()){
        deplacement += [i,j];
        break;
      }
      else{break;}
      }
    }
    j = getPosition()[1];
    while(0 <= --j){ // vers la gauche
      if(echiquier[i][j].getJoueur() == 0){
        deplacement += [i,j];
      }
      else{if(echiquier[i][j].getJoueur() == 3 - getJoueur()){
        deplacement += [i,j];
        break;
      }
      else{break;}
      }
    }
    return deplacement;
  }
}