import 'package:flutter/material.dart';

class ClassesCard extends StatelessWidget {
  final String imgURL;

  ClassesCard(this.imgURL);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 184,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF090F13),
        image: DecorationImage(
            image: Image.network(imgURL).image,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop),
            fit: BoxFit.fitWidth),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shoulder Smith",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                  size: 24,
                )
              ],
            ),
            Divider(
              height: 5,
            ),
            Text(
              '30m | High Intensity | Indoor/Outdoor',
              style: TextStyle(
                color: Color(0xFF39D2C0),
                fontSize: 14,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 120,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text("Reserve"),
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        primary: Colors.white,
                        backgroundColor: Color(0xFF39D2C0),
                        textStyle: TextStyle(fontSize: 14)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "10:00am",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Thursday June 22',
                      style: TextStyle(
                        color: Color(0xB4FFFFFF),
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
