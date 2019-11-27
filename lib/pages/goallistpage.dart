import 'package:flutter/material.dart';
import 'package:social_goal/pages/newgoalpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoalListPage extends StatefulWidget {
  final String userId;
  final String userName;
  GoalListPage({this.userId, this.userName});

  @override
  _GoalListPageState createState() => _GoalListPageState();
}

class _GoalListPageState extends State<GoalListPage> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      new StreamBuilder(
          stream: Firestore.instance.collection('Goals').where("CreatorId",isEqualTo: widget.userId).snapshots(),
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
            else{
              return ListView.builder(
                //itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewGoalPage(userId: widget.userId, userName: widget.userName)));
          })
    );
  }
}