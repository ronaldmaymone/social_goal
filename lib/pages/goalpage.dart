import 'package:flutter/material.dart';
import 'package:social_goal/goal.dart';
class GoalPage extends StatefulWidget {
  Goal goal;

  GoalPage({this.goal});

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // NetworkImage(widget._goal.imgPath),
          //Text(widget._goal.title, style: TextStyle(),),
          //Text(widget._goal.description, style: TextStyle(),),
          // TODO: likes, Tag
        ],
      ),
    );
  }
}
