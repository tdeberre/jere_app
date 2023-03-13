import 'package:flutter/material.dart';
import 'package:jere_app/app/splash.dart';
export 'app/splash.dart';

//import des menus
import 'app/home.dart';
import 'app/decks/decks.dart';
import 'app/decks/builder/builder.dart';
import 'app/game/game.dart';
import 'app/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (BuildContext context) => const MyHomePage());
      case "/login":
        return MaterialPageRoute(builder: (BuildContext context) => const LoginPage());
      case "/game":
        return MaterialPageRoute(builder: (BuildContext context) => const GamePage());
      case "/decks":
        return MaterialPageRoute(builder: (BuildContext context) => const DecksPage());
      case "/decks/builder":
        if (args is String) {
          return MaterialPageRoute(builder: (BuildContext context) => BuilderPage(name: args));
        } else {
          throw ("wrong deck name");
        }
      case "splash":
        return MaterialPageRoute(builder: (BuildContext context) => const Splash());
      default:
        return MaterialPageRoute(builder: (BuildContext context) => const MyHomePage());
    }
  }
}
