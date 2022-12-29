import 'package:banque_projets/service/Authentification.dart';
import 'package:banque_projets/views/HomePage.dart';
import 'package:banque_projets/views/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      StreamProvider.value(
          initialData: null, value: AuthentificationService().user)
    ],
    child: const MyApp(),
  ));

  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank Project',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application

          // is not restarted.
          primarySwatch: Colors.blueGrey,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: const Wrapper(),
      //home: const Wrapper(), //const MyHomePage(title: 'god of war',)
    );
  }
}
