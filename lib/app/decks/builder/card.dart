import 'package:flutter/material.dart';
import 'package:jere_app/database/database.dart';

class Card extends StatelessWidget {
  const Card({required this.name, super.key});

  final String name;
  String get effect => DB.cards[name]["effect"] ?? "???";

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 200,
        maxHeight: 350,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 80),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(children: [
        Text(name),
        Container(
          width: 200,
          height: 150,
          color: Colors.amber,
        ),
        Expanded(
          child: Center(
            widthFactor: double.infinity,
            child: Text(effect.toString()),
          ),
        ),
      ]),
    );
  }
}
