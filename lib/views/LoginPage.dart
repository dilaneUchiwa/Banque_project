import 'package:banque_projets/service/Authentification.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool inLoginProcess = false;

  signInWithGoogle() {
    setState(() {
      inLoginProcess = true;
      AuthentificationService().signInWithGoogle();
    });
  }

  signInWithPhone() {
    setState(() {
      inLoginProcess = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: const Text("Bienvenu dans Bank Project",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width * 0.6,
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage("assets/uds_img.png"))),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: const Text(
              "Ceci est une plateforme concue pour stocker les projets d'un établissement et permettre ainsi aux générations futurs de les consulter ",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            )),
        Container(
            margin: inLoginProcess
                ? const EdgeInsets.only(top: 40)
                : const EdgeInsets.only(top: 10),
            child: inLoginProcess
                ? const Center(child: CircularProgressIndicator())
                : Column(children: [
                    ElevatedButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: const Text(
                            "     Se connecter avec mon compte Google      ",
                            style: TextStyle(
                              fontSize: 12,
                            ))),
                    ElevatedButton(
                        onPressed: () {
                          signInWithPhone();
                        },
                        child: const Text(
                            "Se connecter avec mon numéro de téléphone",
                            style: TextStyle(
                              fontSize: 12,
                            )))
                  ]))
      ],
    ));
  }
}
