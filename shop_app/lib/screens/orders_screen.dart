import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item_widget.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatefulWidget {
  static final routeName = "/ordes";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    final ordersData = Provider.of<Orders>(context);
    if (isInit) {
      isLoading = true;
      ordersData.fetchOrders().then((value) => setState(() {
            setState(() {
              isLoading = false;
            });
          }));
    }

    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (ctx, i) => OrderItemWidget(
                ordersData.orders[i],
              ),
            ),
    );
  }
}
