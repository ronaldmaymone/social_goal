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
  List<DocumentSnapshot> docs = List();

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
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

  Future<void> getDocsSnap() async {
    if (widget.user.followedGoals != null) {
      for (DocumentReference docRef in widget.user.followedGoals) {
        docs.add(await docRef.get());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getDocsSnap();
    debugPrint("Len docs = "+docs.length.toString());
    return Scaffold(
        body:
        ListView.builder(
    //itemExtent: 80.0,
          itemCount: docs.length,
          itemBuilder: (context, index) => index == 0 ? Center(child: Text("Você ainda não segue nenhum objetivo")) :
          _buildListItem(context, docs[index]),
        )
    );
  }
}