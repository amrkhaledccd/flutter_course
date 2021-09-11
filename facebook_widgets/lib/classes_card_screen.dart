import 'package:flutter/material.dart';

import './classes_card.dart';

class ClassesCardScreen extends StatelessWidget {
  static final routeName = "/exec";

  @override
  Widget build(BuildContext context) {
    var list = [
      "https://www.muscleandfitness.com/wp-content/uploads/2013/04/Bodybuilder-Working-Out-His-Shoulders-With-Upright-Rows-Exercise.jpg?quality=86&strip=all",
      "https://img.mensxp.com/media/content/2020/Sep/header_banner_5f66f2a63ec3e.jpeg",
      "https://www.bodybuilding.com/images/2017/august/Samantha-Leete_s-Sculpted-Arm-Workout-header-v2-960x540.jpg",
      "https://www.bodybuilding.com/images/2016/july/6-exercises-for-sexy-and-shapely-shoulders-header-v2-830x467.jpg",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: ListView(
        children: list.map((imgUrl) => ClassesCard(imgUrl)).toList(),
      ),
    );
  }
}
