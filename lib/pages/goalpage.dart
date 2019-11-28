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
      appBar: AppBar(title: Text("Página de Objetivo"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Image.network(widget.goal.imgPath),
            Text(widget.goal.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            Divider(),
            Text(widget.goal.description, style: TextStyle(),),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(child: Icon(Icons.favorite_border), onTap: () {_incrementOrDecrementLikes();},),
                SizedBox(width: 1.0,),
                Text(widget.goal.likes == null? "0" : widget.goal.likes.toString()),
                SizedBox(width: 20.0,),
                Text("Tag = "+widget.goal.tag)
              ],
            )
            // TODO: likes, Tag
          ],
        ),
      ),
    );
  }

  _incrementOrDecrementLikes(){
    // TODO: update number of likes(increment or decrement)
  }
}
