import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../models/category.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  final List<Meal> filteredMeals;
  final Function addToFavorite;
  final Function removeFromFavorite;
  final Function favoriteContains;

  MealsScreen(this.filteredMeals, this.addToFavorite, this.removeFromFavorite,
      this.favoriteContains);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  Category? _category;
  List<Meal> _categoryMeals = [];

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    _category = args['category'] as Category;

    _categoryMeals = widget.filteredMeals
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
        body: _categoryMeals.length == 0
            ? Center(
                child: Text(
                  "No Meals Found",
                  style: Theme.of(context).textTheme.headline5,
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return MealItem(
                    _categoryMeals[index],
                    widget.addToFavorite,
                    widget.removeFromFavorite,
                    widget.favoriteContains,
                  );
                },
                itemCount: _categoryMeals.length,
              ));
  }
}
