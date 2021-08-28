import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String text;

  Txt(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 28),
    );
  }
}
