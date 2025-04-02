import 'package:chess_insa/Piece.dart';


class Tour extends Piece{
  int mouv = 0; // sert à voir si la tour a déjà bougé pour le roque
  Tour(super.id,super.j);
  bool roque(){ // regarde si la tour a déjà bougé
    if(mouv == 0){
      return true;
    }
    return false;
  }
  int getMouv(){
    return mouv;
  }
  void setMouv(int i){
    mouv = i;
  }
  @override
  List mouvPossible(List<List<Piece>> echiquier){
    List deplacement = [];
    int i = getPosition()[0];
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