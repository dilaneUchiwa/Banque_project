import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètre"),
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Flexible(
          flex: 3,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 82, 100, 112).withOpacity(0.3),
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
                    height: 20,
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
            flex: 10,
            child: Column(
              children: [],
            ))
      ],
    ));
  }
}
