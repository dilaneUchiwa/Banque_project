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

class PageContaint extends StatelessWidget {
  const PageContaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
