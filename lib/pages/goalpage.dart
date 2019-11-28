import 'package:flutter/material.dart';
import 'package:social_goal/goal.dart';

class GoalPage extends StatefulWidget {
  Goal goal;
  final String userId;
  final String userName;
  GoalPage({this.goal, this.userId, this.userName});

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {

  bool _alreadyLiked(){
    return widget.goal.likedBy.contains(widget.userId);
  }

  void _incrementOrDecrementLikes(){
    if (_alreadyLiked()){
      return;
    }
    else{
      widget.goal.incrementLike(widget.userId);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Página de Objetivo"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Image.network(widget.goal.imgPath),
            Text(widget.goal.title, style: TextStyle(),),
            Text(widget.goal.description, style: TextStyle(),),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(child: _alreadyLiked()?Icon(Icons.favorite):
                                    Icon(Icons.favorite_border),
                  onTap: () {_incrementOrDecrementLikes();},),
                Text(widget.goal.likes.toString()),
                Text(widget.goal.tag),
              ],
            )
            // TODO: likes, Tag
          ],
        ),
      ),
    );
  }

  Widget coment(){

  }

}
