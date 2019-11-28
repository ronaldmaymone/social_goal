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
    if (widget.user.followedGoals.length >= 1) {
      debugPrint("RETORNEI MAIS OU IGUAL A 1 FOLLOWED GOAL");
      for (String docId in widget.user.followedGoals) {
        DocumentSnapshot ref = await Firestore.instance.collection("Goals").document(docId).get();
        debugPrint("Referência = "+ref.toString());
        docs.add(ref);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getDocsSnap();
    return Scaffold(
        body:
        ListView.builder(
          //itemExtent: 80.0,
          itemCount: widget.user.followedGoals.length,
          itemBuilder: (context, index) => widget.user.followedGoals.length == 0 ? Center(child: Text("Você ainda não segue nenhum objetivo")) :
          _buildListItem(context, docs[index]),
        )
    );
  }
}