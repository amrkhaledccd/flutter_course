import 'package:flutter/material.dart';

import '../screens/category_screen.dart';
import '../screens/favorite_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<String> favoriteIds;

  final Function addToFavorite;
  final Function removeFromFavorite;
  final Function favoriteContains;

  TabsScreen(this.favoriteIds, this.addToFavorite, this.removeFromFavorite,
      this.favoriteContains);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> screens = [];

  @override
  void didChangeDependencies() {
    screens = [
      {
        'page': CategoryScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(widget.favoriteIds, widget.addToFavorite,
            widget.removeFromFavorite, widget.favoriteContains),
        'title': 'My Favorites',
      }
    ];
    super.didChangeDependencies();
  }

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
