import 'package:flutter/material.dart';

import '../models/category.dart';
import '../screens/meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem(this.category);

  void onCategoryClick(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealsScreen.routeName,
      arguments: {'category': category},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onCategoryClick(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [category.color.withOpacity(0.7), category.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
