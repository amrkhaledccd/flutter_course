import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_details_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/add_edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './screens/product_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(null, null, []),
          update: (ctx, auth, previous) =>
              Products(auth.token, auth.userId, previous!.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, null, []),
          update: (ctx, auth, previous) =>
              Orders(auth.token, auth.userId, previous!.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (_, auth, _c) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Color(0xFF6F35A5),
            primaryColorLight: Color(0xFFF1E6FF),
            accentColor: Colors.deepOrange,
            fontFamily: "Lato",
          ),
          home: auth.isAuthenticated() ? ProductOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (_) => UserProductsScreen(),
            AddEditProductScreen.routeName: (_) => AddEditProductScreen(),
          },
        ),
      ),
    );
  }
}
