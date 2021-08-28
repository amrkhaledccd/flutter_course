import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function onPressed;
  final Map<String, Object> ans;

  Answer({this.onPressed, this.ans});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
          onPressed: () => onPressed(ans['score']),
          child: Text(ans['text']),
        ));
  }
}
