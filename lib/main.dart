import 'package:flutter/material.dart';
import 'package:oriontek_test/screens/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  // Here we load the configuration file .env
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appTitle = "Customers Manager";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: HomePage(title: appTitle),
    );
  }
}
