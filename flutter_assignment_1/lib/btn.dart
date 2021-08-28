import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final Function handleChangeText;

  Btn(this.handleChangeText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: handleChangeText, child: Text('Change Text'));
  }
}
