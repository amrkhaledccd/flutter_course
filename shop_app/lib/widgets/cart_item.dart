import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem(
    this.id,
    this.productId,
    this.title,
    this.price,
    this.quantity,
  );

  String itemTotal(double price, int quantity) {
    final total = price * quantity;
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (_) =>
          Provider.of<Cart>(context, listen: false).removeFromCart(productId),
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("Do you want to delete this item?"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("No")),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text("Yes")),
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        padding: EdgeInsets.only(right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              size: 32,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Remove',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$$price'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: ${itemTotal(price, quantity)}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
