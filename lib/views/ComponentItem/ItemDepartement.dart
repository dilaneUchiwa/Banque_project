import 'package:banque_projets/mod%C3%A8le/Departement.dart';
import 'package:banque_projets/views/ComponentList/FiliereList.dart';
import 'package:flutter/material.dart';

class ItemDepartement extends StatelessWidget {
  final Departement dept; // le departement à affichewr

  const ItemDepartement(this.dept);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width * 0.13,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage("assets/uds_img.png"))),
            margin: const EdgeInsets.only(top: 8),
          ),
          //minVerticalPadding: 12,
          tileColor: Colors.white,
          title: Text(
            dept.nom!.toUpperCase(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            var route = MaterialPageRoute(
                builder: (BuildContext context) => FiliereList(dept));
            Navigator.of(context).push(route);
          },
        ),
        const Divider()
      ],
    );
  }
}
