import 'dart:io';
import 'package:banque_projets/views/HomePage.dart';
import 'package:path/path.dart' as p;

import 'package:banque_projets/constante/Style.dart';
import 'package:banque_projets/mod%C3%A8le/Projet.dart';
import 'package:banque_projets/service/DatabaseService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateprojectPage extends StatefulWidget {
  final Projet projet;

  const UpdateprojectPage(this.projet, {super.key});

  @override
  State<UpdateprojectPage> createState() => _UpdateprojectPageState();
}

class _UpdateprojectPageState extends State<UpdateprojectPage> {
  String? titre;
  String? description;

  List<File> images = [];
  File? rapport = null;
  String? nom_rapport = null;

  File? code_source = null;
  String? nom_code = null;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.projet.code_source != null) {
      nom_rapport = "rapport";
      rapport = null;
    }

    print(widget.projet.code_source);

    if (widget.projet.code_source != null) {
      nom_code = "code_source";
      rapport = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Mise à Jour --> Projet"),
            centerTitle: true,
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                          initialValue: widget.projet.titre,
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
                          initialValue: widget.projet.description,
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
                        padding: const EdgeInsets.only(top: 5),
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
                                    : Row()
                              ],
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8)),
                            child: IconButton(
                              onPressed: (() async {
                                File? file;
                                XFile? imagePicker = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
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
                    // les images desja selectionnées

                    images.isNotEmpty
                        ? SizedBox(
                            height: 180,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                itemBuilder: (context, index) => Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: const BorderSide(
                                              color: Colors.white, width: 1)),
                                      child:
                                          Image.file(images.elementAt(index)),
                                    )),
                          )
                        : Row(),

                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
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
                                            result!.files.single.name.length >
                                                    16
                                                ? nom_rapport =
                                                    "(${result.files.single.name.substring(0, 16)}...)${p.extension(result.files.single.path!)}"
                                                : nom_rapport =
                                                    result.files.single.name;
                                            rapport = file;
                                          }
                                        });
                                      },
                                      child: nom_rapport == null
                                          ? const Text(
                                              "cliquez ici pour ajouter",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontStyle: FontStyle.italic),
                                            )
                                          : Text(
                                              nom_rapport!,
                                              style: const TextStyle(
                                                  color: Colors.blue),
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
                                          result!.files.single.name.length > 16
                                              ? nom_code =
                                                  "(${result.files.single.name.substring(0, 16)}...)${p.extension(result.files.single.path!)}"
                                              : nom_code =
                                                  result.files.single.name;
                                          code_source = file;
                                        }
                                      });
                                    },
                                    child: nom_code == null
                                        ? const Text(
                                            "cliquez ici pour ajouter",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic),
                                          )
                                        : Text(
                                            nom_code!,
                                            style: const TextStyle(
                                                color: Colors.blue),
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
                              onPressed: () {
                                setState(() {
                                  formKey.currentState!.reset();
                                  titre = null;
                                  description = null;
                                  nom_code = null;
                                  nom_rapport = null;
                                  code_source = null;
                                  rapport = null;
                                  images = [];
                                });
                              },
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(160, 35)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
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
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'sauvegarde en cours',
                                    ),
                                  ),
                                );
                                var db = DatabaseService();

                                Projet projet = Projet.idNull(
                                    titre!,
                                    description!,
                                    HomePage.user.uid,
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
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "projet crée",
                                  ),
                                ));
                              }
                            },
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    const Size(160, 35)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
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
