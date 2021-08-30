import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static final String routeName = '/filters';
  Map<String, bool> currentFilters;
  Function saveFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegatrian = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegatrian = widget.currentFilters['vegitrian']!;
    _vegan = widget.currentFilters['vegan']!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                Map<String, bool> filters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegitrian': _vegatrian,
                  'vegan': _vegan,
                };
                widget.saveFilters(filters);
              },
              icon: Icon(Icons.save)),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meals",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile("Gluten-Free",
                    "Only include gluten-free meals", _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildSwitchListTile(
                    "Lactose-Free",
                    "Only include lactose-free meals",
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                buildSwitchListTile("Vegan", "Only include vegan meals", _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                buildSwitchListTile(
                    "Vegitrian", "Only include vegitrian meals", _vegatrian,
                    (newValue) {
                  setState(() {
                    _vegatrian = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSwitchListTile(String title, String description, bool val,
      Function(bool) onChangedHanlder) {
    return SwitchListTile(
      value: val,
      onChanged: onChangedHanlder,
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
