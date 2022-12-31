import 'package:banque_projets/mod%C3%A8le/Filiere.dart';
import 'package:banque_projets/mod%C3%A8le/Projet.dart';
import 'package:banque_projets/mod%C3%A8le/Promotion.dart';
import 'package:banque_projets/views/ComponentItem/ItemProject.dart';
import 'package:banque_projets/views/ComponentItem/ItemPromotion.dart';
import 'package:banque_projets/views/ComponentItem/ItemPromotion.dart';
import 'package:flutter/material.dart';

import '../../modèle/Promotion.dart';
import '../../service/DatabaseService.dart';
import '../Errors/serverError.dart';
import '../Errors/widgetVide.dart';

class ProjectList extends StatelessWidget {
  final Promotion _promotion;

  const ProjectList(this._promotion);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LISTE DE PROJETS")),
      body: SafeArea(
          child: StreamBuilder(
              stream: DatabaseService().getPromotionprojects(_promotion),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data is! List<Projet>) {
                  return const ServerError();
                } else {
                  if (snapshot.hasData) {
                    var projet = snapshot.data as List<Projet>;
                    if (projet.isEmpty) {
                      return const WidgetVide(
                          "aucun projet", "dans cette promotion");
                    } else {
                      return Column(children: [
                        ListView.builder(
                          shrinkWrap:
                              true, //Indique si l'étendue de la vue de défilement dans [scrollDirection] doit être déterminée par le contenu affiché.Si la vue de défilement ne se rétracte pas, la vue de défilement s'agrandit jusqu'à la taille maximale autorisée dans [scrollDirection]. Si la vue de défilement a des contraintes illimitées dans [scrollDirection], alors [shrinkWrap] doit être vrai.Réduire le contenu de la vue de défilement coûte beaucoup plus cher que de l'étendre à la taille maximale autorisée, car le contenu peut s'étendre et se contracter pendant le défilement, ce qui signifie que la taille de la vue de défilement doit être recalculée chaque fois que la position de défilement change.La valeur par défaut est false.Donc, en reprenant le vocabulaire des docs, ce qui se passe ici c'est que notre ListViewest dans une situation de contraintes illimitées (dans le sens que l'on fait défiler), donc le ListViewva se plaindre que :
                          itemCount: projet.length,
                          itemBuilder: (context, index) {
                            return ItemProject(projet[index]);
                          },
                        )
                      ]);
                    }
                  } else {
                    return const WidgetVide(
                        "aucun projet", "dans cette promotion");
                  }
                }
              })),
    );
  }
}
