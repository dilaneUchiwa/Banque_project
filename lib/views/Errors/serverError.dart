import 'package:flutter/material.dart';

class ServerError extends StatelessWidget {
  const ServerError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "Impossible de joindre le serveur",
      style: TextStyle(color: Colors.red, fontSize: 18),
    ));
  }
}
