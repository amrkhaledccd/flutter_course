import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/widgets/category_item.dart';

import '../data/dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(25),
      children:
          DUMMY_CATEGORIES.map((category) => CategoryItem(category)).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
