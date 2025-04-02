import 'package:chess_insa/Piece.dart';


class Roi extends Piece{
  int mouv = 0; // sert à voir si la tour a déjà bougé pour le roque
  int echec = 0; //jsp quoi en faire pour l'instant mais ça peut être utile
  Roi(super.id,super.j);
  
  bool roque(){
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
  int getEchec(){
    return echec;
  }
  void setEchec(int i){
    echec = i;
  }
  @override
  List mouvPossible(List<List<Piece>> echiquier){ // il faudrait mettre en place des recherche pour enlever les cases où il est matte
    List deplacement = [];
    int x = getPosition()[0];
    int y = getPosition()[1];
    // toujours pas besoin de différencier joueur 1 et joueur 2
    for(int i = -1; i<2; i++){
      for(int j = -1; j<2;j++){ //autour du roi
        if((0 <=x+i) && (x+i < 8) && (0 <= (y+j)) && ((y+j)< 8)){ // dans les bordures de l'echiquier
          if(echiquier[x+ i][y + j].getJoueur() == getJoueur()){ // si la case ne contient pas un de nos jeton
            deplacement += [x+i,y+j];
          }
        }
      }
    }
    return deplacement;
  }
}