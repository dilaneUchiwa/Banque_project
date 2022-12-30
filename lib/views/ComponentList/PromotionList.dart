import 'package:banque_projets/mod%C3%A8le/Niveau.dart';
import 'package:banque_projets/views/ComponentItem/ItemPromotion.dart';
import 'package:flutter/material.dart';

import '../../modèle/Promotion.dart';
import '../../service/DatabaseService.dart';
import '../Errors/serverError.dart';
import '../Errors/widgetVide.dart';

class PromotionList extends StatelessWidget {
  final Niveau _niveau;

  const PromotionList(this._niveau);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_niveau.designation)),
      body: SafeArea(
          child: StreamBuilder(
              stream: DatabaseService().getPromotions(_niveau),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data is! List<Promotion>) {
                  return const ServerError();
                } else {
                  if (snapshot.hasData) {
                    var promotion = snapshot.data as List<Promotion>;
                    if (promotion.isEmpty) {
                      return const WidgetVide("aucune promotion", "ce niveau");
                    } else {
                      return Column(children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(children: [
                              TextButton(
                                  child: Text(
                                    _niveau.filiere.departement.nom!,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }),
                              const Text(">>>"),
                              TextButton(
                                  child: Text(
                                    _niveau.filiere.nom,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }),
                              const Text(">>"),
                              TextButton(
                                  child: Text(
                                    _niveau.numero.toString(),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ])),
                        ListView.builder(
                          shrinkWrap:
                              true, //Indique si l'étendue de la vue de défilement dans [scrollDirection] doit être déterminée par le contenu affiché.Si la vue de défilement ne se rétracte pas, la vue de défilement s'agrandit jusqu'à la taille maximale autorisée dans [scrollDirection]. Si la vue de défilement a des contraintes illimitées dans [scrollDirection], alors [shrinkWrap] doit être vrai.Réduire le contenu de la vue de défilement coûte beaucoup plus cher que de l'étendre à la taille maximale autorisée, car le contenu peut s'étendre et se contracter pendant le défilement, ce qui signifie que la taille de la vue de défilement doit être recalculée chaque fois que la position de défilement change.La valeur par défaut est false.Donc, en reprenant le vocabulaire des docs, ce qui se passe ici c'est que notre ListViewest dans une situation de contraintes illimitées (dans le sens que l'on fait défiler), donc le ListViewva se plaindre que :
                          itemCount: promotion.length,
                          itemBuilder: (context, index) {
                            return ItemPromotion(promotion[index]);
                          },
                        )
                      ]);
                    }
                  } else {
                    return const WidgetVide("aucune promotion", "ce niveau");
                  }
                }
              })),
    );
  }
}
