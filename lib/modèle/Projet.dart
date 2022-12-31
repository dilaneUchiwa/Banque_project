import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Projet {
  static int total = 0;
  String? id_projet;
  String titre;
  String description;
  //List<String> uidlist;
  String? uidlist;
  Timestamp? timestamp;
  List<dynamic?> images;
  String? rapport;
  String? code_source;
  double? progress=0.6;
  int number;

  Projet(
      this.id_projet,
      this.titre,
      this.description,
      this.uidlist,
      this.timestamp,
      this.images,
      this.rapport,
      this.code_source,
      this.progress,
      this.number) {
    total++;
  }
  Projet.idNull(this.titre, this.description, this.uidlist, this.timestamp,
      this.images, this.rapport, this.code_source, this.progress,this.number);
}
