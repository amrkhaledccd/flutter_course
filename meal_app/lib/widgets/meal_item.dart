import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final Function addToFavorite;
  final Function removeFromFavorite;
  final Function favoriteContains;

  MealItem(
    this.meal,
    this.addToFavorite,
    this.removeFromFavorite,
    this.favoriteContains,
  );

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailsScreen.routeName,
      arguments: {'meal': meal},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    width: 250,
                    color: Colors.black54,
                    child: Text(
                      meal.title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      if (favoriteContains(meal.id)) {
                        removeFromFavorite(meal.id);
                      } else {
                        addToFavorite(meal.id);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                      child: Icon(
                        Icons.star,
                        color: favoriteContains(meal.id)
                            ? Theme.of(context).accentColor
                            : Colors.white,
                        size: 45,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 5),
                      Text('${meal.duration} min'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 5),
                      Text('${describeEnum(meal.complexity)}'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 5),
                      Text('${describeEnum(meal.affordability)}'),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
