import 'package:banque_projets/mod%C3%A8le/Niveau.dart';
import 'package:banque_projets/views/ComponentList/PromotionList.dart';
import 'package:banque_projets/views/mainChoiceWidget.dart';
import 'package:flutter/material.dart';

class ItemNiveau extends StatelessWidget {
  final Niveau niveau;
  const ItemNiveau(this.niveau);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minVerticalPadding: 12,
          tileColor: Colors.white,
          title: Text(
            niveau.designation.toUpperCase(),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Niveau ${niveau.numero}",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent)),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PromotionList(niveau)));
          },
        ),
        const Divider()
      ],
    );
  }
}
