import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'cards_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CardEntry(),
      }));
}
