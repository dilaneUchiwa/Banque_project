import 'package:banque_projets/mod%C3%A8le/Departement.dart';
import 'package:banque_projets/mod%C3%A8le/Filiere.dart';
import 'package:banque_projets/service/DatabaseService.dart';
import 'package:banque_projets/views/ComponentItem/ItemFiliere.dart';
import 'package:flutter/material.dart';
import 'package:banque_projets/views/Errors/widgetVide.dart';

import '../Errors/serverError.dart';

class FiliereList extends StatelessWidget {
  final Departement _departement;

  FiliereList(this._departement);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_departement.nom!)),
      body: SafeArea(
          child: StreamBuilder(
              stream: DatabaseService().getFilieres(_departement),
              builder: (context, snapshot) {
                
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (
                    snapshot.data is! List<Filiere>) {
                  return const ServerError();
                } else {
                  if (snapshot.hasData) {
                    var filiere = snapshot.data as List<Filiere>;
                    if (filiere.isEmpty) {
                      return const WidgetVide(
                          "aucune filière", "ce département");
                    } else {
                      return Column(children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(children: [
                              TextButton(
                                  child: Text(": ${_departement.nom!}",style: const TextStyle(fontSize: 10),),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              const Text(">>")
                            ])),
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap:
                              true, //Indique si l'étendue de la vue de défilement dans [scrollDirection] doit être déterminée par le contenu affiché.Si la vue de défilement ne se rétracte pas, la vue de défilement s'agrandit jusqu'à la taille maximale autorisée dans [scrollDirection]. Si la vue de défilement a des contraintes illimitées dans [scrollDirection], alors [shrinkWrap] doit être vrai.Réduire le contenu de la vue de défilement coûte beaucoup plus cher que de l'étendre à la taille maximale autorisée, car le contenu peut s'étendre et se contracter pendant le défilement, ce qui signifie que la taille de la vue de défilement doit être recalculée chaque fois que la position de défilement change.La valeur par défaut est false.Donc, en reprenant le vocabulaire des docs, ce qui se passe ici c'est que notre ListViewest dans une situation de contraintes illimitées (dans le sens que l'on fait défiler), donc le ListViewva se plaindre que :
                          itemCount: filiere.length,
                          itemBuilder: (context, index) {
                            return ItemFiliere(filiere[index]);
                          },
                        ))
                      ]);
                    }
                  } else {
                    return const WidgetVide("aucune filière", "ce département");
                  }
                }
              })),
    );
  }
}
