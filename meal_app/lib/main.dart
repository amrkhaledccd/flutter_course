import 'package:flutter/material.dart';

import './screens/meals_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/filters_screen.dart';
import './data/dummy_data.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _favorites = [];
  List<Meal> _filteredMeals = DUMMY_MEALS;

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegitrian': false,
    'vegan': false,
  };

  void _saveFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _filteredMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegitrian']! && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _addToFavorite(String mealId) {
    setState(() {
      _favorites.add(mealId);
    });
  }

  void _removeFromFavorite(String mealId) {
    setState(() {
      _favorites.remove(mealId);
    });
  }

  bool _favoriteContains(String mealId) {
    return _favorites.contains(mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      home: TabsScreen(
        _favorites,
        _addToFavorite,
        _removeFromFavorite,
        _favoriteContains,
      ),
      routes: {
        MealsScreen.routeName: (ctx) => MealsScreen(
              _filteredMeals,
              _addToFavorite,
              _removeFromFavorite,
              _favoriteContains,
            ),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _saveFilters),
      },
    );
  }
}
