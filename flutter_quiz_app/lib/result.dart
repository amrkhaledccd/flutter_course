import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function onRest;

  Result({this.totalScore, this.onRest});

  String get responseText {
    return 'You scored $totalScore';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            responseText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800]),
          ),
          TextButton(onPressed: onRest, child: Text('Try again'))
        ],
      ),
    );
  }
}
