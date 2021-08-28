import 'package:flutter/material.dart';

class PostsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Posts",
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.filter_list_alt),
                    label: Text("Filters")),
              ],
            ),
          ),
        ));
  }
}
