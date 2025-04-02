abstract class Piece{
  int id = 1;
  int joueur = 1;
  List position = [1,1];
  // il faudrait ajouter un indicateur pour le symbole qui sera afficher

  Piece(int iD, int J){
    id = iD;
    joueur = J;
  }

  List mouvPossible(List<List<Piece>> echiquier); // depend du type de piece

  int getId(){
    return id;
  }
  int getJoueur(){
    return joueur;
  }
  //pas de setId et setJoueur, on ne devrait pas avoir à les changer, ça garantie aussi leur unicité
  List getPosition(){
    return position;
  }
  void setJoueur(int J){
    joueur = J;
  }
  void setPosition(List P){
    position = P;
  }
}