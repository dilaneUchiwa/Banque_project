import 'package:banque_projets/mod%C3%A8le/Niveau.dart';
import 'package:banque_projets/service/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modèle/Matiere.dart';

class MainChoiceWidget extends StatefulWidget {
  final Niveau niveau;

  const MainChoiceWidget(this.niveau, {super.key});

  @override
  State<MainChoiceWidget> createState() => _MainChoiceWidgetState();
}

class _MainChoiceWidgetState extends State<MainChoiceWidget> {
  List<DropdownMenuItem<dynamic>> Matieres = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> DropdownButtonWithMatieres() async {
    Matieres.clear();
    List<Niveau> list_niveau;
    var liste = await DatabaseService().getMatieres(widget.niveau);
    liste.forEach((element) {
      for (var item in element) {
        Matieres.add(const DropdownMenuItem(value:"i",child: Text("data numero oijooo")));
        print(item.intitue);
      }
    });
    // for (int i = 0; i < 20; i++) {
    //   Matieres.add(DropdownMenuItem(value:i.toString(),child: Text("data numero oijooo")));
    // }
  }

  Widget build(BuildContext context) {
    DropdownButtonWithMatieres();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.niveau.designation),
        ),
        body: Column(
          children: [
            SizedBox(
                height: 50,
                child: Row(children: [
                  TextButton(
                      child:
                          Text(": ${widget.niveau.filiere.departement.nom!}"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                  const Text(">>"),
                  TextButton(
                      child: Text(widget.niveau.filiere.nom),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                  const Text(">>"),
                  TextButton(
                      child: Text("niveau ${widget.niveau.numero.toString()}"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  const Text(">>")
                ])),
            SafeArea(
                child: Form(
                    child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Matiere :",
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton(
                      items: Matieres,
                      onChanged: (value) {},
                      hint:
                          const Text("     Veuillez choisir une matière     "),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "    Code :",
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton(
                      items: Matieres,
                      onChanged: (value) {},
                      hint:
                          const Text("     Veuillez choisir une matière     "),
                    )
                  ],
                )
              ],
            )))
          ],
        ));
  }
}
