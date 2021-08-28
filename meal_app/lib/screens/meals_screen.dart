import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/meal.dart';
import '../models/category.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  Category? _category;
  List<Meal> _categoryMeals = [];

  void _removeMeal(String id) {
    setState(() {
      _categoryMeals.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    _category = args['category'] as Category;

    _categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(_category?.id))
        .toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_category!.title),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(_categoryMeals[index], _removeMeal);
          },
          itemCount: _categoryMeals.length,
        ));
  }
}
