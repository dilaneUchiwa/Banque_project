import 'dart:io';

import 'package:banque_projets/constante/Style.dart';
import 'package:banque_projets/mod%C3%A8le/Projet.dart';
import 'package:banque_projets/service/DatabaseService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewprojectPage extends StatefulWidget {
  final User user;

  const NewprojectPage(this.user, {super.key});

  @override
  State<NewprojectPage> createState() => _NewprojectPageState();
}

class _NewprojectPageState extends State<NewprojectPage> {
  String? titre;
  String? description;

  List<File> images = [];
  File? rapport = null;
  String? nom_rapport = null;

  File? code_source = null;
  String? nom_code = null;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Nouveau Projet"),
            centerTitle: true,
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.home)),
              )
            ]),
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    // titre de la page
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Informations sur le projet".toUpperCase(),
                            style: Style.textStyleTitre,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Titre du projet",
                              hintText: "Entrer le titre de votre projet"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Le titre ne doit pas etre vide";
                            }
                            return null;
                          },
                          onSaved: ((newValue) => titre = newValue),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          maxLines: 5,
                          minLines: 4,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Description du projet",
                              hintText:
                                  "Donner une breve desciption du projet"),
                          validator: (value) {
                            return null;
                          },
                          onSaved: ((newValue) => description = newValue),
                        ))
                      ],
                    ),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(children: [
                          const Text("Images"),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                images.isEmpty
                                    ? const Center(
                                        child: Text(
                                        "aucune image",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic),
                                      ))
                                    : Expanded(
                                        child: Image.file(images.elementAt(0))),
                                if (images.length > 1)
                                  Expanded(
                                      child: Image.file(images.elementAt(1))),
                                if (images.length > 2)
                                  Expanded(
                                      child: Image.file(images.elementAt(2))),
                                if (images.length > 3)
                                  Expanded(
                                      child: Image.file(images.elementAt(3))),
                                if (images.length > 4)
                                  Expanded(
                                      child: Image.file(images.elementAt(4))),
                              ],
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: images.length == 5
                                    ? Colors.grey
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8)),
                            child: IconButton(
                              onPressed: images.length == 5
                                  ? null
                                  : (() async {
                                      File? file;
                                      XFile? imagePicker = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      imagePicker != null
                                          ? file = File(imagePicker.path)
                                          : null;
                                      setState(() {
                                        if (file != null) images.add(file);
                                      });
                                    }),
                              icon: const Icon(Icons.add),
                              color: Colors.white,
                            ),
                          )
                        ]),
                      )
                    ]),
                    if (images.length == 5)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child: Text(
                              "Nombre maximal d'image atteint",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          )
                        ],
                      ),

                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "Rapport",
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Code Source",
                                  )
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        File? file;
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                              'pdf',
                                              'docx',
                                              'doc',
                                              'txt',
                                              'odt'
                                            ]);
                                        result != null
                                            ? file =
                                                File(result.files.single.path!)
                                            : null;
                                        setState(() {
                                          if (file != null) {
                                            nom_rapport =
                                                result!.files.single.name;
                                            rapport = file;
                                          }
                                        });
                                      },
                                      child: nom_rapport == null
                                          ? const Text(
                                              "aucun rapport",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          : Text(
                                              nom_rapport!,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: [
                                            'rar',
                                            '7zip',
                                            'zip'
                                          ]);
                                      File? file;
                                      result != null
                                          ? file =
                                              File(result.files.single.path!)
                                          : null;
                                      setState(() {
                                        if (file != null) {
                                          nom_code = result!.files.single.name;
                                          code_source = file;
                                        }
                                      });
                                    },
                                    child: nom_code == null
                                        ? const Text(
                                            "aucun document",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        : Text(
                                            nom_code!,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ]),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Réinitialiser",
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                                // on sauvegarde l'etat du formulaire

                                formKey.currentState!.save();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'sauvegarde en cours',
                                    ),
                                  ),
                                );
                                var db = DatabaseService();

                                Projet projet = Projet.idNull(
                                    titre!,
                                    description!,
                                    widget.user.uid,
                                    null,
                                    [],
                                    null,
                                    null,
                                    null,
                                    Projet.total + 1);

                                db.uploadProjet(
                                    projet, images, rapport, code_source);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "projet crée",
                                  ),
                                ));
                              }
                            }, //style: ButtonStyle( ),
                            child: const Text(
                              "Enregister",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            )));
  }
}
