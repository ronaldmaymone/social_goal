import "package:flutter/material.dart";

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/sucess_image.jpg"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Goal Title",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Divider(),
                      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                    ],
                  ),
                )
              ],
            ),
          );
    });
  }
}


