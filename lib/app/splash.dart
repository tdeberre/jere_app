import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jere_app/database/database.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    super.initState();
    dbInit();
  }

  dbInit() async {
    DB.init();
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, "/login"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.orange, child: Icon(Icons.settings, size: MediaQuery.of(context).size.height / 2));
  }
}
