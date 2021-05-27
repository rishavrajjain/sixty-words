import 'package:flutter/material.dart';
import 'cards_entry.dart';


void main() => runApp(MaterialApp(
  theme: ThemeData(
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
    initialRoute: '/',
    routes: {
      '/': (context) => CardEntry(),
    }
));
