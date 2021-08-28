import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  void _handleAnswer(int score) {
    print(score);
    _totalScore += score;
    setState(() {
      ++_questionIndex;
    });
  }

  void _rest() {
    _totalScore = 0;
    setState(() {
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    const questions = const [
      {
        'questionText': 'What is your favorite color?',
        'answers': [
          {'text': 'Red', 'score': 8},
          {'text': 'Green', 'score': 5},
          {'text': 'Blue', 'score': 3},
          {'text': 'Yellow', 'score': 1},
        ],
      },
      {
        'questionText': 'What is your favorite animal?',
        'answers': [
          {'text': 'Cat', 'score': 2},
          {'text': 'Dog', 'score': 7},
          {'text': 'Horse', 'score': 6},
          {'text': 'Elephant', 'score': 4},
        ],
      },
      {
        'questionText': 'What is your favorite car manufacturer?',
        'answers': [
          {'text': 'BMW', 'score': 10},
          {'text': 'Ford', 'score': 5},
          {'text': 'Fiat', 'score': 6},
          {'text': 'Honda', 'score': 2},
        ],
      },
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text("Quiz Appp"),
        ),
        body: _questionIndex < questions.length
            ? Quiz(
                questions: questions,
                questionIndex: _questionIndex,
                handleAnswer: _handleAnswer,
              )
            : Result(
                totalScore: _totalScore,
                onRest: _rest,
              ),
      ),
    );
  }
}
