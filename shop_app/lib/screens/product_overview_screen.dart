import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/produt_item.dart';
import '../providers/products.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var isFav = false;
  var isInit = true;
  var isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() => isLoading = true);
      Provider.of<Products>(context)
          .fetchProducts()
          .then((value) => setState(() => isLoading = false));
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  isFav = true;
                } else {
                  isFav = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              CheckedPopupMenuItem(
                child: Text("Only Favorite"),
                value: FilterOptions.Favorite,
                checked: isFav,
              ),
              CheckedPopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
                checked: !isFav,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              color: Theme.of(context).accentColor,
              value: cart.count,
              child: ch!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridViewBuilder(isFav),
      drawer: AppDrawer(),
    );
  }
}

class GridViewBuilder extends StatelessWidget {
  final bool isFav;
  GridViewBuilder(this.isFav);

  @override
  Widget build(BuildContext context) {
    var productsProvider = Provider.of<Products>(context);
    var products =
        isFav ? productsProvider.favoriteItems : productsProvider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
        value: products[idx],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
