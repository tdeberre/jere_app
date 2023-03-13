import 'package:flutter/material.dart';
import 'router.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'jere',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: "splash",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
