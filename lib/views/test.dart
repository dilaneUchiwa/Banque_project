import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Documents:",
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        )
      ],
    );
  }
}
