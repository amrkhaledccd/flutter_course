import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Create Post",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Amr Khaled",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: TextField(
                  minLines: 2,
                  maxLines: 100,
                  decoration: InputDecoration(
                    hintText: "What is on your mind?",
                    hintStyle: TextStyle(fontSize: 18),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey[400]!,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add to your post",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          color: Colors.green[400],
                          size: 25,
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          color: Colors.blue[400],
                          size: 25,
                        ),
                        Icon(
                          Icons.tag_faces,
                          color: Colors.yellow[600],
                          size: 25,
                        ),
                        Icon(
                          Icons.location_on,
                          color: Colors.orange[400],
                          size: 25,
                        ),
                        Icon(
                          Icons.more_horiz,
                          size: 25,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Post"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
