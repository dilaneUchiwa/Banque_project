import 'package:banque_projets/service/Authentification.dart';
import 'package:banque_projets/views/PageView/AboutPage.dart';
import 'package:banque_projets/views/PageView/NewProjectPage.dart';
import 'package:banque_projets/views/PageView/SettingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final User user;
  final PageController pagecontroller;
  const DrawerWidget(this.user, this.pagecontroller, {super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> photo;
    if (widget.user.photoURL == null) {
      photo = const ExactAssetImage("assets/profile_img.png");
    } else {
      try {
        photo = NetworkImage(widget.user.photoURL!);
      } on Exception {
        photo = const ExactAssetImage("assets/profile_img.png");
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // entete du drawer
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              //width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: photo, fit: BoxFit.contain),
                        )),
                    Row(children: [
                      Text(widget.user.displayName!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14)),
                    ]),
                    Row(children: [
                      Text(widget.user.email!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12))
                    ])
                  ]),
            ),

            // Corps du drawer
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewprojectPage(widget.user)));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "Nouveau Projet",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.dashboard_customize,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "Gestion de la structure",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.settings,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "Paramètre",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.info,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "A propos",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => AuthentificationService().signOut(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.logout,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "Se déconnecter",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
