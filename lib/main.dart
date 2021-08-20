import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../screens/login.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Textbelt",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.white
      ),
      home: Login(),
    );
  }
}
