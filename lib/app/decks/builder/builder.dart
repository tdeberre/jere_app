import 'package:flutter/material.dart';
import 'package:jere_app/database/database.dart';

class BuilderPage extends StatefulWidget {
  const BuilderPage({required this.name, super.key});
  final String name;
  @override
  State<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  String active = DB.cards.keys.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deck builder"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (User.decks[widget.name].length == 10) {
                User.decks = User.decks; //
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Deck must be 10 cards")));
              }
            }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView(
                        children: mkList(DB.cards.keys.toList()),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: mkList(User.decks[widget.name].map<String>((e) => e.toString()).toList()),
                      ),
                    ),
                  ],
                ),
              ),
            ), //top lists
            Container(
              height: 200,
              width: double.infinity,
              color: Theme.of(context).colorScheme.background,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(padding: EdgeInsets.all(20)),
                  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(children: [Text(DB.cards[active]["cost"]), Text(active)])),
                    Text(DB.cards[active]["effect"]),
                    const Padding(padding: EdgeInsets.all(0)),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => setState(() {
                            User.decks.addEntries({
                              widget.name: User.decks[widget.name] + [active]
                            }.entries);
                          }),
                          icon: const Icon(Icons.add),
                        ),
                        Text(User.decks[widget.name]
                            .map<String>((e) => e.toString())
                            .where((e) => e == active)
                            .toList()
                            .length
                            .toString()),
                        IconButton(
                          onPressed: () => setState(() {
                            User.decks[widget.name].remove(active);
                          }),
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), //bottom card detail
          ],
        ),
      ),
    );
  }

  //turn a List<String> to a List<Inkwell>
  List<Widget> mkList(List<String> source) {
    List<Widget> list = [];
    for (var item in source.toSet()) {
      list += [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Material(
            color: active == item ? Colors.black38 : Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: InkWell(
              onTap: () => setState(() {
                active = item;
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(item),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(source.where((e) => e == item).length != 1
                        ? "Quantité: ${source.where((e) => e == item).length.toString()}"
                        : ""),
                  ),
                ],
              ),
            ),
          ),
        )
      ];
    }
    return list;
  }
}
