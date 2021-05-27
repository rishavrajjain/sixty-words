import 'package:flutter/material.dart';

class ThankyouCard extends StatelessWidget {
  String title;
  ThankyouCard(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        title,
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
