import 'Projet.dart';

class Utilisateur {
  String id_utilisateur;
  String nom;
  String mail;
  List<Projet> projets = [];

  Utilisateur(
      this.id_utilisateur, this.nom, this.mail,this.projets);
}
