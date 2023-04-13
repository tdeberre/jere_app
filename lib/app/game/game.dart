import 'package:flutter/material.dart';

import 'package:jere_app/database/database.dart';
import 'package:jere_app/database/game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

int active = 0;

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Game.stateAsMap.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> gameState = snapshot.data!;
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: (gameState["hpEnemy"] / 100),
                      minHeight: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        const Text("hand"),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                square(gameState, 0),
                                square(gameState, 1),
                                square(gameState, 2),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                square(gameState, 3),
                                square(gameState, 4),
                                square(gameState, 5),
                              ],
                            ),
                          ],
                          // children: mkHand(gameState["hand"].cast<String>(), gameState),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.background,
                          child: (gameState["hand"].isEmpty)
                              ? ElevatedButton(
                                  child: const Text('draw'),
                                  onPressed: () => setState(() {
                                    game!.draw();
                                  }),
                                )
                              : (gameState["hand"].length - 1 < active)
                                  ? ElevatedButton(
                                      child: const Text('draw'),
                                      onPressed: () => setState(() {
                                        game!.draw();
                                      }),
                                    )
                                  : Text(DB.cards[gameState["hand"][active]]["effect"]),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      color: Colors.lightBlue,
                      value: gameState["hp"] / 100,
                      minHeight: 20,
                      semanticsLabel: "vie",
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  square(gamestate, num) {
    String text;
    if (gamestate["hand"].isNotEmpty) {
      if (gamestate["hand"].length - 1 >= num) {
        text = gamestate["hand"][num];
      } else {
        text = "empty";
      }
    } else {
      text = "empty";
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          active = num;
        });
      },
      onDoubleTap: () {
        try {
          game!.play(gamestate["hand"][num]);
        } catch (e) {}
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: active == num ? Border.all(color: Colors.orange, width: 2) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text),
      ),
    );
  }
}
