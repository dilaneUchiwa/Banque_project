import 'package:banque_projets/modèle/Departement.dart';

class Filiere {
  String? id_filiere;
  String nom;
  Departement departement;
  Filiere(this.id_filiere, this.nom, this.departement);
  Filiere.idNull(Null, this.nom, this.departement);
}
