import 'package:banque_projets/mod%C3%A8le/Niveau.dart';
import 'package:banque_projets/modèle/Matiere.dart';

class Promotion {
  String id_promotion;
  int annee;
  //Matiere matiere;
  Niveau niveau;
  Promotion(this.id_promotion, this.annee, this.niveau);
}
