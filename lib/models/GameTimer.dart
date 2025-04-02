import 'dart:async';

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

  // Retourne le temps restant
  int getTime() {
    return _seconds;
  }
}