import 'package:flutter/material.dart';

import './text_control.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text('Assignment 1'),
        ),
        body: TextControl(),
      ),
    );
  }
}
