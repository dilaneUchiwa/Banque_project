import 'package:banque_projets/views/PageView/ProjectPage.dart';
import 'package:flutter/material.dart';

import '../../modèle/Projet.dart';

class ShowprojectPage extends StatelessWidget {
  Projet projet;

  ShowprojectPage(this.projet, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("BANK PROJECT"),
          centerTitle: true,
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  onPressed: () {
                    //Theme.of(context).primaryColor.value  = Colors.red;
                  },
                  icon: const Icon(Icons.dark_mode)),
            )
          ]),
      //drawer: DrawerWidget(widget.user, _pageController),
      body: ProjectPage(projet),
    );
  }
}
