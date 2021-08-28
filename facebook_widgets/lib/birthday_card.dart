import 'package:flutter/material.dart';

class BirthdayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.card_giftcard_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Birthdays",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          print("button clicked");
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Rami Alaaeldin Ali",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                        text: "\'s birthday is today.",
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ]),
                ),
                onTap: () {
                  print("text clicked");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
