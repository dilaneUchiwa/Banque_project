import 'package:banque_projets/mod%C3%A8le/Filiere.dart';
import 'package:banque_projets/views/ComponentList/niveauList.dart';
import 'package:flutter/material.dart';

class ItemFiliere extends StatelessWidget {
  final Filiere filiere;

  ItemFiliere(this.filiere);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minVerticalPadding: 12,
          tileColor: Colors.white,
          title: Text(
            filiere.nom.toUpperCase(),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => NiveauList(filiere)));
          },
        ),
        const Divider()
      ],
    );
  }
}
