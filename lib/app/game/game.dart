import 'package:flutter/material.dart';

import 'package:jere_app/database/database.dart';
import 'package:jere_app/database/game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

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
                      value: gameState["hpEnemy"] / 100,
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
                        Row(
                          children: mkHand(gameState["hand"].cast<String>(), gameState),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.background,
                          child: ElevatedButton(
                            child: const Text('draw'),
                            onPressed: () => setState(() {
                              game!.draw();
                            }),
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
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

  mkHand(List<String> hand, Map gameState) {
    List<Widget> list = [];
    for (String card in hand) {
      list += [
        GestureDetector(
            onTap: () => setState(() {
                  DB.cards[card].cast<String, dynamic>()["fonc"];
                  gameState["hand"].remove(card);
                }),
            child: CustomCard(
              name: card,
            ))
      ];
    }
    return list;
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.name, this.width = 100, this.height = 100});
  final String name;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      width: width,
      height: height,
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        const Text("icon"),
        Text(name),
        //get card effect
        Text(DB.cards[name]["effect"]),
      ]),
    );
  }
}
