import 'package:flutter/material.dart';

import '../screens/category_screen.dart';
import '../screens/favorite_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> screens = [
    {
      'page': CategoryScreen(),
      'title': 'Categories',
    },
    {
      'page': FavoriteScreen(),
      'title': 'My Favorites',
    }
  ];

  int _selectedTabIndex = 0;

  void selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screens[_selectedTabIndex]['title'].toString()),
      ),
      drawer: MainDrawer(),
      body: screens[_selectedTabIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectTab,
        currentIndex: _selectedTabIndex,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
