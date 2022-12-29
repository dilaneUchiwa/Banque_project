import 'package:banque_projets/modèle/Utilisateur.dart';
import 'package:banque_projets/modèle/Matiere.dart';

class Enseignant extends Utilisateur {
  Matiere matiere;
  Enseignant(this.matiere) : super("","","",[]);
}
