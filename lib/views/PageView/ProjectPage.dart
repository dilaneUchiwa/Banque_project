import 'dart:io';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:banque_projets/constante/Style.dart';
import 'package:banque_projets/mod%C3%A8le/Projet.dart';
import 'package:banque_projets/service/DatabaseService.dart';
import 'package:banque_projets/views/HomePage.dart';
import 'package:banque_projets/views/PageView/NewProjectPage.dart';
import 'package:banque_projets/views/PageView/UpdateProjectPage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectPage extends StatefulWidget {
  Projet projet;
  bool homepage;
  //const ProjectPage({super.key});
  ProjectPage(this.projet, this.homepage, {super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin {
  List<NetworkImage> images = [];

  @override
  void initState() {
    super.initState();

    if (widget.projet.images.isNotEmpty) {
      for (var image in widget.projet.images) {
        try {
          images.add(NetworkImage(image!));
        } catch (e) {
          Image.asset("assets/waiting_icon.png");
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.projet.images.isNotEmpty) {
      for (var image in images) {
        precacheImage(image, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int rapport = widget.projet.rapport == null ? 1 : 0;
    int codesource = widget.projet.code_source == null ? 1 : 0;
    List<String> presence = ["oui", "non"];

    return Scaffold(
      appBar: widget.homepage
          ? null
          : AppBar(
              title: const Text(
                "BANK PROJECT",
                style: TextStyle(fontSize: 18),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Mise à jour",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                        onPressed: () {
                          HomePage.user.uid == widget.projet.uidlist
                              ? updateProject(widget.projet)
                              : updateButtonMessage(this.context);
                        },
                        color: HomePage.user.uid == widget.projet.uidlist
                            ? Colors.white
                            : Colors.grey,
                        iconSize: 35,
                        padding: const EdgeInsets.all(10),
                        icon: const Icon(Icons.update_rounded)),
                  )
                ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.homepage
                ? Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {},
                                padding: const EdgeInsets.all(0),
                                color: Theme.of(context).primaryColor,
                                iconSize: 30,
                                icon: const Icon(Icons.update_rounded)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Mise à jour",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ))
                : Row(),

            // bloc entete du projet
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  widget.projet.titre.toUpperCase(),
                  style: Style.textStyleTitre,
                )
              ]),
            ),
            // partie d'affichage des images
            Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: images.isEmpty
                    ? MediaQuery.of(context).size.height * 0.25
                    : MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Images:",
                              style: Style.textStyleLabel,
                            )
                          ],
                        ),
                      ],
                    ),
                    images.isEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.18,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black)),
                            child: const Center(
                              child:
                                  Text("Aucune image trouvée pour ce projet"),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            child: Carousel(
                              boxFit: BoxFit.fill,
                              borderRadius: true,
                              indicatorBgPadding: 1,
                              radius: const Radius.circular(8),
                              images: images,
                            ),
                          )
                  ],
                )),

            //bloc description du projet
            Container(
              padding: const EdgeInsets.all(8),
              height: widget.projet.description.length >= 300
                  ? MediaQuery.of(context).size.height *
                      0.21 *
                      (widget.projet.description.length / 280)
                  : MediaQuery.of(context).size.height * 0.21,
              child: Column(children: [
                Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Description:",
                          style: Style.textStyleLabel,
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                    child: Column(children: [
                  Text(widget.projet.description, style: Style.textStyleContenu)
                ]))
              ]),
            ),

            //bloc indicateur de progression
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(children: const [
                  Text(
                    "Progression:",
                    style: Style.textStyleLabel,
                  )
                ]),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width * 0.65,
                          animation: true,
                          lineHeight: 20,
                          animationDuration: 2000,
                          percent: widget.projet.progress! / 100,
                          center: Text("${widget.projet.progress!}%"),
                          progressColor: Colors.greenAccent.shade400,
                          barRadius: const Radius.circular(15),
                        )))
              ]),
            ),

            // bloc presence des  documents
            Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.11,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // titre de la partie
                      Column(
                        children: const [
                          Text(
                            "Documents:",
                            style: Style.textStyleLabel,
                          )
                        ],
                      ),
                      //type Document
                      Container(
                          width: MediaQuery.of(context).size.width * 0.36,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "Rapport",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Code Source",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          )),

                      // document oui ou non
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    presence[rapport],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    presence[codesource],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.red),
                                  )
                                ],
                              )
                            ],
                          ))
                    ])),

            //bloc date de mise a jour
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(children: const [
                  Text(
                    "Mise à jour :    le",
                    style: Style.textStyleLabel,
                  )
                ]),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Row(children: [
                    Text(widget.projet.timestamp!.toDate().toString(),
                        style: const TextStyle(
                            color: Colors.blue, fontStyle: FontStyle.italic))
                  ]),
                ))
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => download(widget.projet),
        child: Icon(Icons.download),
      ),
    );
  }

  void updateButtonMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.65),
        behavior: SnackBarBehavior.floating,
        content: const Text(
            "Seul les proprietaires de ce projet peuvent le modifier")));
  }

  Future<void> download(Projet projet) async {
    var download = await DatabaseService().downloadProjet(projet);
    if (download == 1) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          content: Text("projet ${projet.titre} téléchargé")));
    } else if (download == 0) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          content: const Text("Echec de téléchargement")));
    }
  }

  void updateProject(Projet projet) {
    // Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UpdateprojectPage(projet)));
  }
}
