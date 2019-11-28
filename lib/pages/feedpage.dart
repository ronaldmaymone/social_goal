import "package:flutter/material.dart";
import 'package:social_goal/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_goal/pages/goalpage.dart';

/*class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Goal _goal;
  // TODO: Colocar o retorno do firebase nesse _goal

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            child: Card(
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
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GoalPage(goal: _goal)),
              );
            },
          );
    });
  }
}*/

//import "package:flutter/material.dart";
//import 'package:social_goal/pages/goalpage.dart';
//import 'package:social_goal/goal.dart';

class FeedPage extends StatefulWidget {
  final String userId;
  final String userName;
  FeedPage({this.userId,this.userName});
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  /*
  No firebase existem Goals testes com as Tags: Saúde, Educação, Esporte e Games
   */
  var usertags = ["Saúde", "Educação", "Esporte"];

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Column(
          children: <Widget>[
            Image.network(document["ImgPath"]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(document["Title"],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                  Text("Created by ${document["CreatorName"]}",
                      style: TextStyle(fontStyle: FontStyle.italic,fontSize: 10.0)),
                  Divider(),
                  Text(document["Description"])  // TEXT DESCRIPTION FROM ABOVE
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoalPage(goal: Goal(document),userId: widget.userId,userName: widget.userName)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        new StreamBuilder(
            stream: Firestore.instance.collection("Goals").snapshots(),
                    //where("CreatorId",isGreaterThan: widget.userId).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData){
                return Scaffold(
                    body: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text("Loading Objectives",style: TextStyle(fontWeight: FontWeight.bold)),
                            CircularProgressIndicator()
                          ],
                        )
                    )
                );
              }
              else {
                return ListView.builder(
                  //itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                    usertags == null|| usertags.contains(snapshot.data.documents[index]["Tag"])?
                      _buildListItem(context, snapshot.data.documents[index]):
                      Container(), //build an empty Widget if tag isn't in usersTag
                );
              }
            }),
    );
  }
}



