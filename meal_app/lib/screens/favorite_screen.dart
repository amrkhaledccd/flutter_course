import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<String> favoriteIds;
  final Function addToFavorite;
  final Function removeFromFavorite;
  final Function favoriteContains;

  FavoriteScreen(
    this.favoriteIds,
    this.addToFavorite,
    this.removeFromFavorite,
    this.favoriteContains,
  );

  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeals =
        DUMMY_MEALS.where((meal) => favoriteIds.contains(meal.id)).toList();

    return Center(
      child: favoriteMeals.length == 0
          ? Center(
              child: Text("No meals found"),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(
                  favoriteMeals[index],
                  addToFavorite,
                  removeFromFavorite,
                  favoriteContains,
                );
              },
              itemCount: favoriteMeals.length,
            ),
    );
  }
}
