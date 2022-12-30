import 'package:banque_projets/modèle/Filiere.dart';

class Niveau {
  String? id_niveau;
  int numero;
  String designation;
  Filiere filiere;
  Niveau(this.id_niveau, this.numero, this.designation,this.filiere);
  Niveau.idNull(Null, this.numero, this.designation,this.filiere);
}
