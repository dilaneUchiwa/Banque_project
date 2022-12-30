class Departement {
  String? id_departement;
  String? nom;
  static int nbre_total = 0;

  Departement(String id_departement, String nom) {
    this.id_departement = id_departement;
    this.nom = nom;
    nbre_total++;
  }
  Departement.idnull(String nom) {
    this.nom = nom;
    nbre_total++;
  }
}
