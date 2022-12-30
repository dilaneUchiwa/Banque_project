import 'package:flutter/material.dart';

import '../../modèle/Departement.dart';
import '../../service/DatabaseService.dart';
import '../ComponentItem/ItemDepartement.dart';
import '../Errors/serverError.dart';
import '../Errors/widgetVide.dart';

class DepartementList extends StatelessWidget {
  const DepartementList({super.key});
  //const List<Departement>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Départements de l'IUT"), centerTitle: true),
        //drawer: const DrawerWidget(),
        body: SafeArea(
            child: StreamBuilder(
                stream: DatabaseService().departements,
                builder: ((context, snapshot) {
                  //snapshot.connectionState==ConnectionState.none
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
                }))));
  }
}
