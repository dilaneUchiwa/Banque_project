import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A propos"),
      ),
      body: const PageContaint(),
    );
  }
}

class PageContaint extends StatelessWidget {
  const PageContaint({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: AssetImage('assets/author.png'),
            radius: 70.0,
          ),
          const Text(
            'dilane uchiwa',
            style: TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          const SizedBox(
            width: 300.0,
            height: 30.0,
          ),
          const Text(
            "Developpeur de logiciels",
            style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.teal,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            width: 300.0,
            height: 10.0,
          ),
          const SizedBox(
            width: 280.0,
            height: 20.0,
            child: Divider(
              color: Colors.grey,
              thickness: 5.0,
            ),
          ),
          Card(
            color: Colors.white,
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: ListTile(
              leading: const Icon(
                Icons.email,
                color: Colors.grey,
                size: 30.0,
              ),
              title: const Text(
                'sagueuwakam@gmail.com',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                  onPressed: () => launch_url("mailto:sagueuwakam@gmail.com"),
                  icon: const Icon(Icons.arrow_forward)),
            ),
          ),
          Card(
            color: Colors.white,
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: ListTile(
              leading: const Icon(
                FontAwesomeIcons.phone,
                color: Colors.teal,
                size: 30.0,
              ),
              title: const Text(
                '693856214/653805146',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                  onPressed: () => launch_url("tel:+237 693856214"),
                  icon: const Icon(Icons.arrow_forward)),
            ),
          ),
          Card(
            color: Colors.white,
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: ListTile(
              leading: const Icon(
                FontAwesomeIcons.github,
                color: Colors.black,
                size: 30.0,
              ),
              title: const Text(
                'dilane Uchiwa (github)',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                  onPressed: () =>
                      launch_url("https://github.com/dilaneUchiwa"),
                  icon: const Icon(Icons.arrow_forward)),
            ),
          ),
          const Text(
            "The future...",
            style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> launch_url(String url) async {
  if (!await launchUrlString(url)) throw "could not launch $url";
}
