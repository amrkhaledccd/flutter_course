import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"),
              ),
              title: Text("Amr Khaled"),
              subtitle: Text(DateFormat.yMMMd().format(DateTime.now())),
              trailing: Icon(Icons.more_horiz),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 15, left: 10),
                  child: Text(
                    "This an example of post text, looking good!",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Ahmed, Ali and 9 others",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  Text(
                    "1 Comment",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.grey[800]),
                  onPressed: () {},
                  icon: Icon(Icons.thumb_up_off_alt_outlined),
                  label: Text("Like"),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.grey[800]),
                  onPressed: () {},
                  icon: Icon(Icons.comment_outlined),
                  label: Text("Comment"),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.grey[800]),
                  onPressed: () {},
                  icon: Icon(Icons.share),
                  label: Text("Share"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
