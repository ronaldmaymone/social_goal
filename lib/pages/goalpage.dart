import 'package:flutter/material.dart';
import 'package:social_goal/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      widget.goal.decrementLike(widget.userId);
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
            Text(widget.goal.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
            Text(widget.goal.description, style: TextStyle(),),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(child: _alreadyLiked()?Icon(Icons.favorite):
                                    Icon(Icons.favorite_border),
                  onTap: () {_incrementOrDecrementLikes();},),
                Text(widget.goal.likes.toString()),
                SizedBox(width: 20.0,),
                Text(widget.goal.tag),
              ],
            ),
           SizedBox(height: 20),
           StreamBuilder(
                stream: widget.goal.coments.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData){
                      return Scaffold(
                        body: Container(
                          alignment: Alignment.center,
                          child: Column(children: <Widget>[
                              Text("Loading Comments",style: TextStyle(fontWeight: FontWeight.bold)),
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
              })
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_comment),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Comment(goal: widget.goal,userName: widget.userName)));
            })
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(document["User"],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text(document["Date"],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                    ],
                  ),
                  Text(document["Message"],
                      style: TextStyle(fontStyle: FontStyle.italic,fontSize: 10.0)),
                  Divider(),  // TEXT DESCRIPTION FROM ABOVE
                ],
              ),
            )
          ],
        ),
      );
  }
}

class Comment extends StatefulWidget{
  final BaseGoal goal;
  final String userName;
  Comment({this.goal, this.userName});

  @override
  State<StatefulWidget> createState() => _CommentState();
}

class _CommentState extends State<Comment>{
  Map<String,dynamic> newComment = {"Date": null, "Message":null, "User": null};
  TextEditingController _commentController;

  _saveComment() async{
    //debugPrint(_commentController.text);
    newComment["Date"] = DateTime.now();
    newComment["User"] = widget.userName;
    //newComment["Message"] = _commentController.text;
    await widget.goal.coments.document(widget.goal.id).setData(newComment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment"),centerTitle: true),
      body: ListView(
        children: <Widget>[
          TextFormField(
            maxLines: null,
            decoration: InputDecoration(border: OutlineInputBorder(),
                labelText: "Digite o seu comentário"),
            controller: _commentController,
              onChanged: (newvalue){
                setState(() {
                  newComment['Message'] = newvalue;
                });
              },
          ),
          RaisedButton(
              color: Colors.blue,
              child: Text("Comentar"),
              onPressed:() async {
                await _saveComment();
                Navigator.pop(context);
              }
          ),
        ],
      )
    );
  }

}