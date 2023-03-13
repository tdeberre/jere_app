import 'package:flutter/material.dart';
import 'package:jere_app/database/database.dart';

class DecksPage extends StatefulWidget {
  const DecksPage({super.key});
  @override
  State<DecksPage> createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes decks")),
      body: Center(
        child: ListView(children: decksList()),
      ),
    );
  }

  List<Widget> decksList() {
    List<Widget> list = [];
    for (var deck in User.decks.keys) {
      list += [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: (MediaQuery.of(context).size.width - 250) / 2),
          child: Material(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, "/decks/builder", arguments: deck),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(deck),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Tooltip(
                      message: "Play with this deck",
                      child: InkWell(
                        onTap: () => setState(() {
                          User.activeDeck = deck;
                        }),
                        child: User.activeDeck == deck ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ];
    }
    return list;
  }
}
