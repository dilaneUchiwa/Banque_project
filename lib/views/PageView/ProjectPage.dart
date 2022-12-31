import 'dart:io';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:banque_projets/constante/Style.dart';
import 'package:banque_projets/mod%C3%A8le/Projet.dart';
import 'package:banque_projets/service/DatabaseService.dart';
import 'package:banque_projets/views/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class ProjectPage extends StatefulWidget {
  Projet projet;
  //const ProjectPage({super.key});
  ProjectPage(this.projet, {super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    animation = Tween(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var images = const [
    //   ExactAssetImage("assets/uds_img.png"),
    //   ExactAssetImage("assets/icon1.png"),
    //   ExactAssetImage("assets/icon2.png"),
    //   ExactAssetImage("assets/icon3.png"),
    //   ExactAssetImage("assets/icon4.png"),
    //   ExactAssetImage("assets/icon6.png"),
    // ];
    List<NetworkImage> images = [];
    int rapport = widget.projet.rapport == null ? 1 : 0;
    int codesource = widget.projet.code_source == null ? 1 : 0;
    List<String> presence = ["oui", "non"];

    if (widget.projet.images.isNotEmpty) {
      for (var image in widget.projet.images) {
        images.add(NetworkImage(image!));
      }
    }

    void buildDialog() =>
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("permission"),
              content: Text(
                  "You will not be able to use this feature without enabling it now?"),
              actions: <Widget>[
                ElevatedButton(
                    child: Text("settings"),
                    onPressed: () {
                      openAppSettings();
                      Navigator.of(context).pop();
                    }),
                ElevatedButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });

    print(HomePage.user.uid);
    print(widget.projet.uidlist);
    print(HomePage.user);

    return Column(
      children: [
        // bloc entete du projet
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              widget.projet.titre.toUpperCase(),
              style: Style.textStyleTitre,
            )
          ]),
        ),
        // partie d'affichage des images
        Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            height: MediaQuery.of(context).size.height * 0.25,
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
                          child: Text("Aucune image trouvée pour ce projet"),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Carousel(
                          boxFit: BoxFit.contain,
                          borderRadius: true,
                          indicatorBgPadding: 8,
                          radius: const Radius.circular(8),
                          images: images,
                        ),
                      )
              ],
            )),

        //bloc description du projet
        Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height * 0.21,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Column(children: const [
              Text(
                "Description:",
                style: Style.textStyleLabel,
              )
            ]),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(children: [
                Text(widget.projet.description, style: Style.textStyleContenu)
              ]),
            ))
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
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
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
                      width: MediaQuery.of(context).size.width * 0.33,
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

        //bloc indicateur de progression
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Column(children: const [
              Text(
                "Mise à jour :",
                style: Style.textStyleLabel,
              )
            ]),
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.68,
                      animation: true,
                      lineHeight: 20,
                      animationDuration: 2000,
                      percent: 0.6,
                      center: Text("${widget.projet.progress! * 100}%"),
                      progressColor: Colors.greenAccent.shade400,
                      barRadius: const Radius.circular(15),
                    )))
          ]),
        ),

        // Bloc des boutons d'actions sur le projet
        Container(
            padding: const EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * 0.09,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        var download = await DatabaseService()
                            .downloadProjet(widget.projet);
                        if (download == 1) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "projet ${widget.projet.titre} téléchargé")));
                        } else if (download == 0) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              behavior: SnackBarBehavior.floating,
                              content: const Text("Echec de téléchargement")));
                        } else {
                          buildDialog();
                        }
                      },
                      style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(160, 35)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      child: const Text(
                        "Télécharger",
                        style: TextStyle(fontSize: 18),
                      )),
                  ElevatedButton(
                      onPressed: HomePage.user.uid == widget.projet.uidlist
                          ? null
                          : updateButtonMessage,
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(160, 35)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            HomePage.user.uid == widget.projet.uidlist
                                ? MaterialStateProperty.all(
                                    Theme.of(context).primaryColor)
                                : MaterialStateProperty.all(Colors.grey),
                        elevation:
                            MaterialStateProperty.all<double>(animation!.value),
                      ),
                      child: const Text(
                        "Modifier",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ])),
      ],
    );
  }

  void updateButtonMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
        content: const Text(
            "Seul les proprietaires de ce projet peuvent le modifier")));
  }
}
