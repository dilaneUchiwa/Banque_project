import 'package:banque_projets/mod%C3%A8le/Projet.dart';
import 'package:banque_projets/views/PageView/ProjectPage.dart';
import 'package:flutter/material.dart';

class ItemProject extends StatelessWidget {
  Projet projet;

  ItemProject(this.projet, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.white, width: 1)),
      child: Column(
        children: [
          ListTile(
              minVerticalPadding: 12,
              tileColor: Colors.white,
              leading: const Text("TITRE"),
              title: Text(
                projet.titre.toUpperCase(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              subtitle: Text(
                  projet.description.length >= 120
                      ? "${projet.description.substring(0, 120)}   ............."
                      : projet.description,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProjectPage(projet, false)));
              }),
        ],
      ),
    );
  }
}
