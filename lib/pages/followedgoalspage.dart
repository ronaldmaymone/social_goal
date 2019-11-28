import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_goal/user.dart';

class FollowedGoalPage extends StatefulWidget {
  final User user;
  FollowedGoalPage({this.user});

  @override
  _FollowedGoalPageState createState() => _FollowedGoalPageState();
}

class _FollowedGoalPageState extends State<FollowedGoalPage> {

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    if (widget.user.followedGoals.contains(document.documentID)){
      return Card(
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
      );
    }
    else{
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //getDocsSnap();
    return Scaffold(
        body:
        new StreamBuilder(
          stream: Firestore.instance.collection("Goals").snapshots(),
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
                    _buildListItem(context, snapshot.data.documents[index])
                );
              }
            }),
    );
  }
}