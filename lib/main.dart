import 'dart:ffi';
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



bool appartient(List<dynamic> L, int i,int j){
  for(int k = 0; k<L.length;k++){
    if((L[k][0] == i) && (L[k][1] == j)){
      return true;
    }
  }
  return false;
}
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
class Vide extends Piece{ // Pour gérer les cases vides
  Vide():super(0,0); // id = 0 et joueur = 0 sera le repère pour savoir si la piece est Vide
  @override
  List mouvPossible(List<List<Piece>> echiquier){
    return [];
  }
}
class GameTimer{
  int _initial = 0;
  int _seconds = 0;
  Timer? _timer;
  bool tourne = false;
  int id = 1;
  int joueur = 1;

  GameTimer(int iD,int j){
    id = iD;
    joueur = j;
    setInitial(60);
    _seconds = _initial;
  }
  void arret(){
    if(!tourne){return;} // si il ne tourne pas
    _timer?.cancel(); // sinon on l'arrete
    tourne = false; // on met l'indice à faux
    return;
  }
  void demarre(){
    if(tourne){return;} // si il tourne deja
    tourne = true; // indice à vrai
    _timer = Timer.periodic(Duration(seconds : 1), (timer){ // créer un timer qui change chaque seconds
      if(_seconds > 0){ // si on peut le décrémenter
        //setState((){
        //  _seconds--; // baisse de 1 chaque secondes
        //});
      }
      else {
        arret(); // sinon on l'arrete
        // faudra envoyer un truc pour signaler une victoire par temps
      }
    }); 
    return;
  }
  void resetTime(){
    arret(); // arrêt du timer
    _seconds = _initial; // on le remet au temps initial
    //setState((){_seconds;}); // chat
    return;
  }
  int getId(){
    return id;
  }
  int getJoueur(){
    return joueur;
  }
  void setInitial(int t){
    _initial = t;
  }
}
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
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
