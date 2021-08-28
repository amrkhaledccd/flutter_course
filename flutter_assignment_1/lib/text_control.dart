import 'package:flutter/material.dart';

import './btn.dart';
import './txt.dart';

class TextControl extends StatefulWidget {
  @override
  _TextControlState createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  var _text = 'This is original text';

  void _handleChangeText() {
    setState(() {
      _text = 'Text has been changed!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Txt(
            this._text,
          ),
          Btn(
            this._handleChangeText,
          )
        ],
      ),
    );
  }
}
