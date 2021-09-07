import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item_widget.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  static final routeName = "/ordes";

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, i) => OrderItemWidget(
          ordersData.orders[i],
        ),
      ),
    );
  }
}
