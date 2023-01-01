import 'package:banque_projets/constante/Style.dart';
import 'package:flutter/material.dart';

import '../../modèle/Departement.dart';
import '../../service/DatabaseService.dart';
import '../ComponentItem/ItemDepartement.dart';

class StructurePage extends StatefulWidget {
  const StructurePage({super.key});

  @override
  State<StructurePage> createState() => _StructurePageState();
}

class _StructurePageState extends State<StructurePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gestion de l'etablissement",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: const PageContaint(),
    );
  }
}

class PageContaint extends StatefulWidget {
  const PageContaint({super.key});

  @override
  State<PageContaint> createState() => _PageContaintState();
}

class _PageContaintState extends State<PageContaint> {
  @override
  var departements = DatabaseService().departements;

  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Flexible(
          flex: 3,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 82, 100, 112).withOpacity(0.3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Structure de l'etablissement",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cette partie est reservée aux administrateurs de l'établissement ",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ),
        Flexible(
            flex: 10,
            child: Column(
              children: [
                Card(
                    child: ExpansionTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Départements"),
                        Container(
                          width: 45,
                          height: 45,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.15)),
                          child: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.add)),
                        ),
                      ]),
                  children: [
                    StreamBuilder(
                        stream: DatabaseService().departements,
                        builder: ((context, snapshot) {
                          var depatements = snapshot.data as List<Departement>;

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Row(children: const [
                              Text("Chargement en cours..."),
                              CircularProgressIndicator()
                            ]));
                          } else {
                            if (depatements.isEmpty) {
                              return const Center(
                                  child: Text("Aucun département"));
                            } else {
                              return ListView.builder(
                                itemCount: depatements.length,
                                itemBuilder: (context, index) {
                                  return ItemDepartement(depatements[index]);
                                },
                              );
                            }
                          }
                        }))
                  ],
                )),
                Card(
                    child: ExpansionTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Filières"),
                              Container(
                                width: 45,
                                height: 45,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.15)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
                              )
                            ]),
                        children: [])),
                Card(
                    child: ExpansionTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Promotions"),
                              Container(
                                width: 45,
                                height: 45,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.15)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
                              )
                            ]),
                        children: [])),
              ],
            ))
      ],
    ));
  }
}
