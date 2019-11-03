import 'package:flutter/material.dart';
import 'package:social_goal/pages/newgoalpage.dart';

class GoalPage extends StatefulWidget {

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  List<Widget> goalList;
  @override
  initState(){
    if (goalList == null) goalList = List();
    debugPrint("Inside init state and len = "+ goalList.length.toString());
    super.initState();
  }

  _updateList(List<Widget> _goalList) {
    setState(() {
      debugPrint("len of goal list from new = " + _goalList.length.toString());
      goalList = _goalList;
      debugPrint("Len after updating list = "+goalList.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint(widget.goalList.length.toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: goalList.length == 0 ? Center(child: Text("Você não possui Objetivos criados")) : ListView.builder(
            itemCount: goalList.length,
            itemBuilder: (BuildContext context, int index){
              return goalList[index];}    //HERE WILL BE SHOWN THE GOAL LIST
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewGoalPage(notifyUpdate: _updateList
                , goalList: goalList,)),
            );
          }),
    );
  }
}