import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// DB.cards
// User.name
//      .pwd
//      .decks
//      .activedeck
// game

class DB {
  static Future<void> init() async {
    _cards = jsonDecode(await getDataFromServ("cards")).cast<String, dynamic>();
  }

  static Map<String, dynamic> get cards => _cards;
  static set cards(Map<String, dynamic> cards) {
    _cards = cards;
  }
}

Map<String, dynamic> _cards = {}; //accessors in DB

///set name and pwd before calling init
class User {
  static Future<void> init(username, password) async {
    User.username = username;
    User.password = password;
    String data = await getDataFromServ("decks/${User.username}");
    if (data == "null") {
      throw "Error: User not found";
    }
    _decks = jsonDecode(data);
    User.activeDeck = _decks.keys.first;
  }

  static late String username;
  static late String password;
  static String activeDeck = "";
  static Map<String, dynamic> get decks => _decks;
  static set decks(Map<String, dynamic> decks) {
    _decks = decks;
    postDataToServ("decks/${User.username}", jsonEncode(_decks));
  }
}

Map<String, dynamic> _decks = {}; //accessors in User

Future<String> getDataFromServ(String path) async {
  String url = "http://localhost:56561/$path";
  try {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw ("Error: ${response.reasonPhrase}");
    }
    print(path);
    print(response.body);
    return response.body;
  } catch (e) {
    throw e;
  }
}

Future<String> postDataToServ(String path, String body) async {
  String url = "http://localhost:56561/$path";
  try {
    http.Response response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode != 201) {
      throw ("Error: ${response.reasonPhrase}");
    }
    print(path);
    print("${response.statusCode}: ${response.body}");
    return response.body;
  } catch (e) {
    throw e;
  }
}
