import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../screens/add_edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static final routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddEditProductScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, i) => UserProductItem(
                  products.items[i].id,
                  products.items[i].title,
                  products.items[i].imageUrl,
                )),
      ),
    );
  }
}
