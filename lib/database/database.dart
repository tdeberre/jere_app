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
    User.token = jsonDecode(await postDataToServ("token", '{"email":"$username","password":"$password"}'));
    _refreshToken();
    String data = await getDataFromServ("decks/${User.username}");
    if (data == "null") {
      throw "Error: User not found";
    }
    _decks = jsonDecode(data);
    User.activeDeck = _decks.keys.first;
  }

  static late String username;
  static late String password;
  static late String token;
  static String activeDeck = "";
  static Map<String, dynamic> get decks => _decks;
  static set decks(Map<String, dynamic> decks) {
    _decks = decks;
    postDataToServ("decks/${User.username}", jsonEncode(_decks));
  }
}

Map<String, dynamic> _decks = {}; //accessors in User
_refreshToken() async {
  Timer.periodic(const Duration(minutes: 14), (timer) async {
    User.token = await postDataToServ(
      "token",
      '{"email":"${User.username}","password":"${User.password}"}',
    );
  });
}

Future<String> getDataFromServ(String path) async {
  String url = "http://localhost:56561/api/$path";
  try {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw ("Error: ${response.reasonPhrase}");
    }
    return response.body;
  } catch (e) {
    rethrow;
  }
}

Future<String> postDataToServ(String path, String body) async {
  String url = "http://localhost:56561/api/$path";
  try {
    http.Response response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode != 201) {
      throw ("Error: ${response.reasonPhrase}");
    }
    return response.body;
  } catch (e) {
    rethrow;
  }
}
