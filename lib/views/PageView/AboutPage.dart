import 'package:flutter/material.dart';

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
        children: const <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/author.png'),
            radius: 70.0,
          ),
          Text(
            'dilane uchiwa',
            style: TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 30.0,
          ),
          Text(
            "Developpeur d'applications",
            style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.teal,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 20.0,
            child: Divider(
              color: Colors.grey,
              thickness: 5.0,
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.teal,
                size: 30.0,
              ),
              title: Text(
                'sagueuwakam@gmail.com',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.teal,
                size: 30.0,
              ),
              title: Text(
                '693856214/653805146',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: ListTile(
              leading: Icon(
                Icons.g_mobiledata,
                color: Colors.teal,
                size: 30.0,
              ),
              title: Text(
                'mon github',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
