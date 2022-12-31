import 'package:banque_projets/mod%C3%A8le/Projet.dart';
import 'package:banque_projets/mod%C3%A8le/Utilisateur.dart';
import 'package:banque_projets/views/ComponentItem/ItemProject.dart';
import 'package:banque_projets/views/PageView/NewProjectPage.dart';
import 'package:banque_projets/views/PageView/ProjectPage.dart';
import 'package:banque_projets/views/PageView/OtherProjectPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/DatabaseService.dart';
import 'Component/drawerWidget.dart';

class HomePage extends StatefulWidget {
  static User user = user;

  HomePage(User user, {super.key}) {
    HomePage.user = user;
  }
  //HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> _NavigationBarItems = [];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _NavigationBarItems.add(const BottomNavigationBarItem(
        label: "Mes projets", icon: Icon(Icons.my_library_books)));
    _NavigationBarItems.add(const BottomNavigationBarItem(
        label: "Autres Projets", icon: Icon(Icons.other_houses)));
  }

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
        drawer: DrawerWidget(HomePage.user, _pageController),
        body: PageView(
          onPageChanged: ((value) {
            setState(() {
              _currentIndex = value;
            });
          }),
          controller: _pageController,
          children: [
            StreamBuilder(
                stream: DatabaseService().getUserprojects(HomePage.user),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Row(children: const [
                      Text("Chargement en cours..."),
                      CircularProgressIndicator()
                    ]));
                  }
                  if (!(snapshot.hasData) ||
                      (snapshot.data as List<Projet>).isEmpty) {
                    return const Center(
                        child: Text("Vous n'avez aucun projet"));
                  } else {
                    var listeProjet = snapshot.data as List<Projet>;
                    if (listeProjet.length == 1) {
                      return ProjectPage(listeProjet[0]);
                    } else {
                      return SafeArea(
                        child: Column(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 82, 100, 112),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                            "BIENVENU ... \t\t\t\t\t|\t\t\t\t\t VOICI VOS DIFFERENTS PROJETS",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ))),
                            Flexible(
                                flex: 12,
                                child: Container(
                                    height: double.infinity,
                                    child: ListView.builder(
                                        itemCount: listeProjet.length,
                                        itemBuilder: (context, index) {
                                          return ItemProject(
                                              listeProjet[index]);
                                        })))
                          ],
                        ),
                      );
                    }
                  }
                })),
            const OtherProjectPage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: _NavigationBarItems,
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              //Navigator.pop(context);
              _pageController.jumpToPage(value);
              _currentIndex = value;
            });
          },
        ));
  }
}
