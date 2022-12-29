import 'package:flutter/material.dart';

class WidgetVide extends StatelessWidget {
  final String nature_fils;
  final String nature_pere;

  const WidgetVide(this.nature_fils, this.nature_pere, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Il n'y a $nature_fils dans",
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$nature_pere",
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )
          ],
        )
      ],
    );
  }
}
