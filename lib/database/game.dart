import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'database.dart';

Game? game;

class Game {
  static StreamController<Map<String, dynamic>> stateAsMap = StreamController<Map<String, dynamic>>();
  late Socket socket;

  void draw() {
    socket.write("draw");
    print("draw");
  }

  void play(String card) {
    socket.write("play $card");
    print("play");
  }

  Future<void> connect() async {
    socket = await Socket.connect("localhost", 56562);
    String creds = jsonEncode({"name": User.username, "pwd": User.password, "deck": User.decks[User.activeDeck]});
    print(creds);
    socket.write(creds);
    socket.listen(
      (Uint8List data) {
        _state = jsonDecode(String.fromCharCodes(data));
        stateAsMap.add(_state);
        print("state: $_state");
      },
      onDone: () {
        socket.close();
      },
      onError: (error) {
        print(error);
        socket.close();
      },
    );
  }
}

late Map<String, dynamic> _state; //accessor in Game