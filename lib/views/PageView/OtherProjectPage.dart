import 'dart:ui';

import 'package:banque_projets/mod%C3%A8le/Departement.dart';
import 'package:banque_projets/service/DatabaseService.dart';
import 'package:banque_projets/views/ComponentItem/ItemDepartement.dart';
import 'package:banque_projets/views/Errors/serverError.dart';
import 'package:banque_projets/views/Errors/widgetVide.dart';
import 'package:flutter/material.dart';

class OtherProjectPage extends StatelessWidget {
  const OtherProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //gradient: Gradient(colors: <Color>[Colors.red,]) ,
                  color: Color.fromARGB(255, 82, 100, 112),
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("DEPARTEMENT DANS LEQUEL SE TROUVE LE PROJET",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ],
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: StreamBuilder(
                stream: DatabaseService().departements,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        semanticsValue: "Chargement en cours...",
                      ),
                    );
                  } else if (snapshot.data is! List<Departement>) {
                    return const ServerError();
                  } else {
                    if (snapshot.hasData) {
                      var depatements = snapshot.data as List<Departement>;
                      if (depatements.isEmpty) {
                        return const WidgetVide(
                            "aucun département", "cet établissement");
                      } else {
                        return ListView.builder(
                          itemCount: depatements.length,
                          itemBuilder: (context, index) {
                            return ItemDepartement(depatements[index]);
                          },
                        );
                      }
                    } else {
                      return const WidgetVide(
                          "aucun département", "cet établissement");
                    }
                  }
                })),
          )
        ],
      ),
    );
  }
}
