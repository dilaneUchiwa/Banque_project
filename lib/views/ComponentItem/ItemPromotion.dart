import 'package:banque_projets/views/ComponentList/projectList.dart';
import 'package:flutter/material.dart';

import '../../modèle/Promotion.dart';

class ItemPromotion extends StatelessWidget {
  final Promotion promotion;
  const ItemPromotion(this.promotion);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minVerticalPadding: 12,
          tileColor: Colors.white,
          title: Text(
            "PROMOTION ${promotion.annee.toString()}",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    ProjectList(promotion)));
          },
        ),
        const Divider()
      ],
    );
  }
}
