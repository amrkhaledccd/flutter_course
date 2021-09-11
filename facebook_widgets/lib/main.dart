import 'package:flutter/material.dart';

import './birthday_card.dart';
import './new_post.dart';
import './posts_title.dart';
import './post.dart';
import './classes_card_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facbook widgets',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MyHomePage(title: 'Facbook widgets'),
      routes: {
        ClassesCardScreen.routeName: (_) => ClassesCardScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text(title),
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar,
        body: ListView(
          children: [
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(ClassesCardScreen.routeName);
                },
                icon: Icon(Icons.fitness_center),
                label: Text('Exercises')),
            BirthdayCard(),
            NewPost(),
            PostsTitle(),
            Post(),
          ],
        ),
      ),
    );
  }
}
