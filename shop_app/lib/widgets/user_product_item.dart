import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/add_edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: Image.network(imageUrl).image,
        ),
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AddEditProductScreen.routeName,
                    arguments: id,
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () {
                  showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text("Are you sure?"),
                            content: Text("Do you want to delete this item?"),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text("No")),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text("Yes")),
                            ],
                          )).then((value) async {
                    if (value!) {
                      try {
                        await Provider.of<Products>(context, listen: false)
                            .removeProduct(id);
                      } catch (error) {
                        scaffoldMessenger.showSnackBar(SnackBar(
                          content: Text('Failed to delete product'),
                        ));
                      }
                    }
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}
