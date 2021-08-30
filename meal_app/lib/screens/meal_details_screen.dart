import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  static const String routeName = '/meal-details';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final Meal meal = args['meal'] as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            MealSection(
              text: "Ingredients",
              child: ListView.builder(
                itemBuilder: (_, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      meal.ingredients[index],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MealSection(
                text: "Steps",
                child: ListView.builder(
                  itemBuilder: (_, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      if (index < meal.steps.length - 1)
                        Divider(
                          thickness: 2,
                        ),
                    ],
                  ),
                  itemCount: meal.steps.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealSection extends StatelessWidget {
  final String text;
  final Widget child;

  MealSection({required this.text, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            text,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 200,
          width: 350,
          child: child,
        ),
      ],
    );
  }
}
