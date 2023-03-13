import 'package:flutter/material.dart';
import 'package:jere_app/database/game.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu principal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                game = Game();
                await game!.connect();
                //ignore:use_build_context_synchronously
                Navigator.pushNamed(context, "/game");
              },
              child: const Text("Jouer"),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/decks"),
              child: const Text("Mes deck"),
            ),
          ],
        ),
      ),
    );
  }
}
