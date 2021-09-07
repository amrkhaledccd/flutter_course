import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem order;

  OrderItemWidget(this.order);

  String itemTotal(double price, int quantity) {
    final total = price * quantity;
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ExpansionTile(
        textColor: Theme.of(context).accentColor,
        title: Text('\$${order.amount.toStringAsFixed(2)}'),
        subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(order.createAt)),
        children: order.cartItems
            .map(
              (item) => ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Text('\$${item.price}'),
                    ),
                  ),
                ),
                title: Text('${item.title}'),
                subtitle:
                    Text('Total: ${itemTotal(item.price, item.quantity)}'),
                trailing: Text('${item.quantity} x'),
              ),
            )
            .toList(),
      ),
    );
  }
}
