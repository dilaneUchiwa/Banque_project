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
  User user;
  HomePage(this.user);

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
        label: "Autre Projets", icon: Icon(Icons.other_houses)));
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
        drawer: DrawerWidget(widget.user, _pageController),
        body: PageView(
          onPageChanged: ((value) {
            setState(() {
              _currentIndex = value;
            });
          }),
          controller: _pageController,
          
          children: [
            StreamBuilder(
                stream: DatabaseService().getUserprojects(widget.user),
                builder: ((context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
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
                      return ListView.builder(
                          itemCount: listeProjet.length,
                          itemBuilder: (context, index) {
                            return ItemProject(listeProjet[index]);
                          });
                    }
                  }
                })),
            const OtherProjectPage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Theme.of(context).primaryColor,
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
