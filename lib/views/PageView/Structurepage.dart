import 'package:banque_projets/constante/Style.dart';
import 'package:banque_projets/mod%C3%A8le/Filiere.dart';
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
  String? nom1;
  String? nom2;

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 1.5,
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 82, 100, 112)
                            .withOpacity(0.3),
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
                            height: 10,
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
                    flex: 20,
                    child: Column(
                      children: [
                        Card(
                            child: ExpansionTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Départements",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
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
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: Text(
                                                    "Nouveau département",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  content: TextFormField(
                                                    onChanged: (value) {
                                                      setState(() {
                                                        nom1 = value;
                                                      });
                                                    },
                                                    // ignore: prefer_const_constructors
                                                    decoration: InputDecoration(
                                                      labelText: 'nom',
                                                      border:
                                                          OutlineInputBorder(),
                                                      prefixIcon: Icon(Icons
                                                          .drive_file_rename_outline),
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'Annuler');
                                                      },
                                                      child:
                                                          const Text('Annuler'),
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.pop(context,
                                                            'Enregistrer');
                                                        print("yo----$nom1");
                                                      },
                                                      child: const Text(
                                                          'Enregistrer'),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      icon: const Icon(Icons.add)),
                                ),
                              ]),
                          children: [
                            StreamBuilder(
                                stream: DatabaseService().departements,
                                builder: ((context, snapshot) {
                                  if (snapshot.data != null) {
                                    var depatements =
                                        snapshot.data as List<Departement>;
                                    if (depatements.isEmpty) {
                                      return const Center(
                                          child: Text("Aucun département"));
                                    } else {
                                      return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: SingleChildScrollView(
                                            child: DataTable(
                                              columns: const [
                                                DataColumn(label: Text("Nom"))
                                              ],
                                              rows: depatements
                                                  .map((departement) =>
                                                      DataRow(cells: [
                                                        DataCell(Text(
                                                            departement.nom!))
                                                      ]))
                                                  .toList(),
                                            ),
                                          ));
                                    }
                                  } else {
                                    return const Center(
                                        child: Text("Aucun département"));
                                  }
                                }))
                          ],
                        )),
                        Card(
                            child: ExpansionTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Filières",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
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
                                ),
                              ]),
                          children: [
                            StreamBuilder(
                                stream: DatabaseService().departements,
                                builder: ((context, snapshot) {
                                  if (snapshot.data != null) {
                                    var depatements =
                                        snapshot.data as List<Departement>;
                                    if (depatements.isEmpty) {
                                      return const Center(
                                          child: Text("Aucun département"));
                                    } else {
                                      return StreamBuilder(
                                          stream: DatabaseService()
                                              .getFilieres(depatements.first),
                                          builder: ((context, snapshot) {
                                            if (snapshot.data != null) {
                                              var filieres = snapshot.data
                                                  as List<Filiere>;
                                              if (filieres.isEmpty) {
                                                return const Center(
                                                    child:
                                                        Text("Aucune filière"));
                                              } else {
                                                return SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: DataTable(
                                                        columns: const [
                                                          DataColumn(
                                                              label: Text(
                                                                  "Filière")),
                                                          DataColumn(
                                                              label: Text(
                                                                  "Département"))
                                                        ],
                                                        rows: filieres
                                                            .map(
                                                                (filiere) =>
                                                                    DataRow(
                                                                        cells: [
                                                                          DataCell(
                                                                              Text(filiere.nom)),
                                                                          DataCell(Text(filiere
                                                                              .departement
                                                                              .nom!))
                                                                        ]))
                                                            .toList(),
                                                      ),
                                                    ));
                                              }
                                            } else {
                                              return const Center(
                                                  child:
                                                      Text("Aucune filière"));
                                            }
                                          }));
                                    }
                                  } else {
                                    return const Center(
                                        child: Text("Aucun département"));
                                  }
                                }))
                          ],
                        )),
                      ],
                    ))
              ],
            )));
  }
}
