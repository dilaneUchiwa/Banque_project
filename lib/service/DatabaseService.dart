import 'dart:io';
import 'package:banque_projets/mod%C3%A8le/Etablissement.dart';
import 'package:path/path.dart' as p;
import 'package:banque_projets/mod%C3%A8le/Departement.dart';
import 'package:banque_projets/mod%C3%A8le/Filiere.dart';
import 'package:banque_projets/mod%C3%A8le/Groupe.dart';
import 'package:banque_projets/mod%C3%A8le/Matiere.dart';
import 'package:banque_projets/mod%C3%A8le/Niveau.dart';
import 'package:banque_projets/mod%C3%A8le/Projet.dart';
import 'package:banque_projets/mod%C3%A8le/Promotion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseService {
  //Instance de notre base de données cloud_firestore
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //Instance de notre espace de stockage pour nos fichiers
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Ajout des éléments dans la BD

  void AddProjet(Projet projet) {
    _db.collection("Projet").add({
      "titre": projet.titre,
      "description": projet.description,
      "images": projet.images,
      "rapport": projet.rapport,
      "code_source": projet.code_source,
      "timestamp": FieldValue.serverTimestamp(),
      "uid": projet.uidlist,
      "progress": 2,
      "promotion":Promotion.triche,
      "number": projet.number
    }).then((DocumentReference doc) => projet.id_projet = doc.id);

    Projet.total++;
    _db
        .collection("Etablissement")
        .doc(Etablissement.id)
        .update({"total": Projet.total});
  }

  void AddDepartement(Departement dept) {
    _db.collection("Departement").add({"nom": dept.nom}).then(
        (DocumentReference doc) => dept.id_departement = doc.id);
  }

  void AddFiliere(Filiere filiere) {
    _db
        .collection("Departement")
        .doc(filiere.departement.id_departement)
        .collection("Filiere")
        .add({"nom": filiere.nom}).then(
            (DocumentReference doc) => filiere.id_filiere = doc.id);
  }

  void AddNiveau(Niveau niveau) {
    _db
        .collection("Departement")
        .doc(niveau.filiere.departement.id_departement)
        .collection("Filiere")
        .doc(niveau.filiere.id_filiere)
        .collection("Niveau")
        .add({"numero": niveau.numero, "désignation": niveau.designation}).then(
            (DocumentReference doc) => niveau.id_niveau = doc.id);
  }

  void AddMatiere(Matiere matiere) {
    _db
        .collection("Departement")
        .doc(matiere.niveau.filiere.departement.id_departement)
        .collection("Filiere")
        .doc(matiere.niveau.filiere.id_filiere)
        .collection("Niveau")
        .doc(matiere.niveau.id_niveau)
        .collection("Matiere")
        .add({"intitulé": matiere.intitue}).then(
            (DocumentReference doc) => matiere.id_matiere = doc.id);
  }

  //Mise à jour des éléments de la BD

  void UpdateProjet(Projet projet, String ref) {
    _db.collection("Projet").doc(ref).update({
      "titre": projet.titre,
      "description": projet.description,
      "images": projet.images,
      "timestamp": FieldValue.serverTimestamp(),
    });
    projet.code_source != null
        ? _db.collection("Projet").doc(ref).update({
            "code_source": projet.code_source,
          })
        : null;
    projet.rapport != null
        ? _db.collection("Projet").doc(ref).update({
            "rapport": projet.rapport,
          })
        : null;
  }

  //Récuperation des éléments de la BD

  Stream<List<Departement>> get departements {
    return _db
        .collection("Departement")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              return Departement(document.id, document.get("nom"));
            }).toList());
  }

  Stream<List<Filiere>> getFilieres(Departement dept) {
    return _db
        .collection("Departement")
        .doc(dept.id_departement)
        .collection("Filiere")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              return Filiere(document.id, document.get("nom"), dept);
            }).toList());
  }

  Stream<List<Niveau>> getNiveaux(Filiere filiere) {
    return _db
        .collection("Departement")
        .doc(filiere.departement.id_departement)
        .collection("Filiere")
        .doc(filiere.id_filiere)
        .collection("Niveau")
        .orderBy("numéro", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              return Niveau(
                  document.id,
                  int.parse(document.get("numéro").toString()),
                  document.get("désignation"),
                  filiere);
            }).toList());
  }

  Stream<List<Niveau>> getNiveauxtest() {
    return _db
        .collection("Niveau")
        .orderBy("numéro", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              return Niveau(
                  document.id,
                  int.parse(document.get("numéro").toString()),
                  document.get("désignation"),
                  Filiere(
                      "iijihjiu", "ygyugyu", Departement("ygyg", "yuyugu")));
            }).toList());
  }

  Stream<List<Matiere>> getMatieres(Niveau niveau) {
    return _db
        .collection("Departement")
        .doc(niveau.filiere.departement.id_departement)
        .collection("Filiere")
        .doc(niveau.filiere.id_filiere)
        .collection("Niveau")
        .doc(niveau.id_niveau)
        .collection("Matiere")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              return Matiere(document.id, document.get("code_ue"),
                  document.get("intitulé"), niveau);
            }).toList());
  }

  Stream<List<Promotion>> getPromotions(Niveau niveau) {
    return _db
        .collection("Departement")
        .doc(niveau.filiere.departement.id_departement)
        .collection("Filiere")
        .doc(niveau.filiere.id_filiere)
        .collection("Niveau")
        .doc(niveau.id_niveau)
        .collection("Promotion")
        .orderBy("annee", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              return Promotion(document.id,
                  int.parse(document.get("annee").toString()), niveau);
            }).toList());
  }

  // Stream<List<Promotion>> getPromotions(Matiere matiere) {
  //   return _db
  //       .collection("Departement")
  //       .doc(matiere.niveau.filiere.departement.id_departement)
  //       .collection("Filiere")
  //       .doc(matiere.niveau.filiere.id_filiere)
  //       .collection("Niveau")
  //       .doc(matiere.niveau.id_niveau)
  //       .collection("Matiere")
  //       .doc(matiere.id_matiere)
  //       .collection("Promotion")
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((document) {
  //             return Promotion(document.id,
  //                 int.parse(document.get("annee").toString()), matiere);
  //           }).toList());
  // }

  // Stream<List<Groupe>> getGroupes(Promotion promotion) {
  //   return _db
  //       .collection("Departement")
  //       .doc(promotion.matiere.niveau.filiere.departement.id_departement)
  //       .collection("Filiere")
  //       .doc(promotion.matiere.niveau.filiere.id_filiere)
  //       .collection("Niveau")
  //       .doc(promotion.matiere.niveau.id_niveau)
  //       .collection("Matiere")
  //       .doc(promotion.matiere.id_matiere)
  //       .collection("Promotion")
  //       .doc(promotion.id_promotion)
  //       .collection("Groupe")
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((document) {
  //             return Groupe(document.id,
  //                 int.parse(document.get("numéro").toString()), promotion);
  //           }).toList());
  // }

  Stream<List<Projet>> getUserprojects(User user) {
    _db
        .collection("Etablissement")
        .where("nom", isEqualTo: "iut")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              Etablissement.id = document.id;
              Projet.total = document.get("total");
            }).toList());

    return _db
        .collection("Projet")
        .where("uid", isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              return Projet(
                  document.id,
                  document.get("titre"),
                  document.get("description"),
                  document.get("uid"),
                  document.get("timestamp"),
                  document.get("images"),
                  document.get("rapport"),
                  document.get("code_source"),
                  document.get("progress"),
                  document.get("number"));
            }).toList());
  }

  Stream<List<Projet>> getPromotionprojects(Promotion promotion) {
    return _db
        .collection("Projet")
        .where("promotion", isEqualTo: promotion.id_promotion)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              return Projet(
                  document.id,
                  document.get("titre"),
                  document.get("description"),
                  document.get("uid"),
                  document.get("timestamp"),
                  document.get("images"),
                  document.get("rapport"),
                  document.get("code_source"),
                  document.get("progress"),
                  document.get("number"));
            }).toList());
  }

  // suppression d'element de la structure

  void DeleteProjet(Projet projet) {
    _db.collection("Projet").doc(projet.id_projet).delete();
  }

  // fonction de téléchargement et sauvegarde d'elements
  Future<void> uploadProjet(
      Projet projet, List<File> images, File? rapport, File? codeSource) async {
    projet.number = Projet.total + 1;

    final String projectLocation =
        "projet/projet${projet.number}"; //l'aborescence ou sera stocker le projet dans clous_storage
    Reference reference; //le chemin d'acess et le nom de stockage
    UploadTask uploadTask; //le tache de mise en ligne
    TaskSnapshot taskSnapshot;

    //les resultats de cette taches

    // sauvegarde des images

    int i = 1;
    for (var image in images) {
      reference = _storage
          .ref()
          .child("$projectLocation/images/image$i${p.extension(image.path)}");
      uploadTask = reference.putFile(image);
      taskSnapshot = await uploadTask;
      projet.images.add(await taskSnapshot.ref.getDownloadURL());
      i++;
    }

    //sauvegarde du rapport

    if (rapport != null) {
      reference = _storage
          .ref()
          .child("$projectLocation/rapport${p.extension(rapport.path)}");
      uploadTask = reference.putFile(rapport);
      taskSnapshot = await uploadTask;
      projet.rapport = await taskSnapshot.ref.getDownloadURL();
    }

    //sauvegarde du code source

    if (codeSource != null) {
      reference = _storage
          .ref()
          .child("$projectLocation/code_source${p.extension(codeSource.path)}");
      uploadTask = reference.putFile(codeSource);
      taskSnapshot = await uploadTask;
      projet.code_source = await taskSnapshot.ref.getDownloadURL();
    }

    //on ajoute le projet dans la base de donnees
    AddProjet(projet);
  }

  Future<int> downloadProjet(Projet projet) async {
    var status = await Permission.storage.status;

    if (status.isGranted) {
      print("Permission is granted");
    } else if (status.isDenied) {
      if (await Permission.storage.request().isGranted) {
        print("Permission was granted");
      } else {
        return -1;
      }
    }
    await Permission.storage.request().isGranted &&
        await Permission.manageExternalStorage.request().isGranted;

    int state = 0;
    DownloadTask downloadTask; //le tache de telechargement en ligne
    Reference fileRef;
    File file;
    String filepath;

    //final fileRef = _storage.ref().child("projet/projet1/images/image2.png");

    final appDocDir = await getExternalStorageDirectory();
    var dirpath = appDocDir!.parent.parent.parent.parent.path;

    // on cree un repertoire pour l'application si ca n'existe

    if (!Directory("$dirpath/Bank Project").existsSync()) {
      await Directory("$dirpath/Bank Project").create(recursive: true);
    }
    dirpath = "$dirpath/Bank Project";

    // on cree un repertoire pour le projet si ca n'existe

    if (!Directory("$dirpath/${projet.titre}").existsSync()) {
      await Directory("$dirpath/${projet.titre}").create(recursive: true);
    }
    dirpath = "$dirpath/${projet.titre}";

    if (projet.rapport != null) {
      fileRef = _storage.refFromURL(projet.rapport!);
      filepath = "$dirpath/rapport${p.extension(fileRef.fullPath)}";
      file = File(filepath);
      downloadTask = fileRef.writeToFile(file);
    }

    if (projet.code_source != null) {
      fileRef = _storage.refFromURL(projet.code_source!);
      filepath = "$dirpath/code_source${p.extension(fileRef.fullPath)}";
      file = File(filepath);
      downloadTask = fileRef.writeToFile(file);
    }
    // on cree un repertoire pour le image si ca n'existe

    if (!Directory("$dirpath/images").existsSync()) {
      await Directory("$dirpath/images").create(recursive: true);
    }
    dirpath = "$dirpath/images";

    int cpt_images = 1;

    for (var element in projet.images) {
      fileRef = _storage.refFromURL(element!);
      filepath = "$dirpath/image$cpt_images${p.extension(fileRef.fullPath)}";
      file = File(filepath);
      downloadTask = fileRef.writeToFile(file);
      cpt_images++;
    }
    state = 1;
    // try {
    //   downloadTask = fileRef.writeToFile(file);
    //   downloadTask.snapshotEvents.listen((taskSnapshot) {
    //     switch (taskSnapshot.state) {
    //       case TaskState.running:
    //         state = 0;
    //         break;
    //       case TaskState.success:
    //         state = 1;
    //         break;
    //       case TaskState.paused:
    //         // TODO: Handle this case.
    //         break;
    //       case TaskState.canceled:
    //         // TODO: Handle this case.
    //         state = 0;
    //         break;
    //       case TaskState.error:
    //         state = 0;
    //         // TODO: Handle this case.
    //         break;
    //     }
    //   });
    // } catch (e) {
    //   print("Erreur ici :${e}");
    // }
    return state;
  }
}
