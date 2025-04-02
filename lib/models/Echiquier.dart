import "GameTimer.dart";
import "Piece.dart";
import 'pieces/Cavalier.dart';
import 'pieces/Fou.dart';
import 'pieces/Pion.dart';
import 'pieces/Reine.dart';
import 'pieces/Roi.dart';
import 'pieces/Tour.dart';
import 'pieces/Vide.dart';

bool appartient(List<dynamic> L, int i,int j){
  for(int k = 0; k<L.length;k++){
    if((L[k][0] == i) && (L[k][1] == j)){
      return true;
    }
  }
  return false;
}

class Echiquier{
  // le 0,0 est en bas à droite
  // les id sont uniques sauf pour les pions
  // les pions vont de 1 à 8 et peuvent être differencier par leur joueur
  // les tours sont entre 10 et 19
  // les cavalier entre 20 et 29
  // les fous entre 30 et 39
  // les rois entre 40 et 49
  // et les reines entre 50 et 59
  int id = 1;
  int tour = 1; // gestion des tours de jeux
  List<GameTimer> tempGestor = [GameTimer(1,1),GameTimer(2,2)];
  List<List<Piece>> plateau = [[]];

  Echiquier(int iD){
    id = iD;
  }
  
  void changeTour(){
    tempGestor[tour - 1].arret();
    tour = 3 - tour;
    tempGestor[tour -1].demarre();
  }

  void init(int temps){
    // on commence par remplir le plateau de case vide puis on place les autres pieces
    // rempli les cases extremes avec des pieces vides pour pouvoir placer facilement les pieces speciales
    // reset les timers avec un temps initial de temps(arg)
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        Piece P = Vide(); // je genere une case sans Piece
        P.setPosition([i,j]); // je met ses coordonnees
        plateau[i] += [P]; // et je l'ajoute
      }
      plateau += [];
    }
    // on place les pieces
    // les tours
    plateau[0][0]=Tour(10,1);
    plateau[0][7]=Tour(11,1);
    plateau[7][7]=Tour(12,2);
    plateau[7][0]=Tour(13,2);
    // les cavaliers
    plateau[0][1]=Cavalier(20,1);
    plateau[0][6]=Cavalier(21,1);
    plateau[7][6]=Cavalier(22,2);
    plateau[7][1]=Cavalier(23,2);
    // les fous
    plateau[0][2]=Fou(30,1);
    plateau[0][5]=Fou(31,1);
    plateau[7][5]=Fou(32,2);
    plateau[7][2]=Fou(33,2);
    // les rois
    plateau[0][3] = Roi(40,1);
    plateau[7][3] = Roi(41,2);
    // les reines
    plateau[0][4] = Reine(50,1);
    plateau[7][4] = Reine(51,2);
    // les pions
    for(int i = 1; i <9;i++){
      plateau[1][i-1] = Pion(i,1);
      plateau[6][i-1] = Pion(i,2);
    }

    // timer
    tempGestor[0].setInitial(temps);
    tempGestor[0].resetTime();
    tempGestor[1].setInitial(temps);
    tempGestor[1].resetTime();
  }
  bool estControler(int i, int j, int joueur){
    // on cherche à savoir si la case i,j est controlée par le joueur 
    // evidemment on suppose que la case i,j est occupée par une piece vide
    // d'abord on fait la liste des cases controler par le joueur
    List controlee = [];
    for(int k = 0; k <8; k++){
      for (int l=0;l<8;l++){
        if(plateau[k][l].getJoueur() == joueur){ // si la case contient un piont du joueur
          controlee += plateau[k][l].mouvPossible(plateau); // on ajoute ses deplacement possible à la liste dees cases controlee
        }
      }
    }
    // ensuite on a juste à chercher [i,j] dans la liste controlee
    for(int k=0; k<controlee.length; k++){
      if((controlee[k][0] == i) && (controlee[k][1] == j)){
        return true;
      }
    }
    return false;
  }
  Piece deplacer(int iDepart, int jDepart, int iArrivee, int jArrivee){
    if(plateau[iDepart][jDepart].getJoueur() == tour){ // si le joueur deplace un pion valide
      List deplacement = plateau[iDepart][jDepart].mouvPossible(plateau);

      if(!appartient(deplacement,iArrivee,jArrivee)){
        return Vide(); // si la case n'est pas accessible par la piece, on ne fait pas le deplacement
      }
      if(plateau[iArrivee][jArrivee].getJoueur() == 0){ // si la case est vide, pas besoin d'intermediaire
        plateau[iArrivee][jArrivee] = plateau[iDepart][jDepart]; // on deplace la piece
        plateau[iDepart][jDepart] = Vide(); // et on met une piece vide à sa place
        changeTour(); // change le tour de jeux
        return Vide();
      }
      Piece intermediaire = plateau[iArrivee][jArrivee];
      plateau[iArrivee][jArrivee] = plateau[iDepart][jDepart]; // on deplace la piece
      plateau[iDepart][jDepart] = Vide(); // et on met une piece vide à sa place
      changeTour(); // change le tour de jeu
      return intermediaire;
    }
    return Vide();
  }
}