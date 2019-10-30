import 'package:flutter/material.dart';
import 'package:social_goal/pages/goalpage.dart';
//import 'objectivescreen.dart';
import 'profilescreen.dart';
import 'feedpage.dart';
import 'package:social_goal/auth.dart';
import 'package:social_goal/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.userId, this.onSignedOut});
  final BaseAuth auth;
  //final BaseUser user;
  final String userId;
  final VoidCallback onSignedOut;

  final drawerItems = [
    new DrawerItem("Feed", Icons.rss_feed),
    new DrawerItem("Meu Perfil", Icons.account_circle),
    new DrawerItem("Objetivos", Icons.arrow_upward),
  ];

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  BaseUser _user;

  @override
  void initState() {
    super.initState();
    _getUser().then((user){
      setState(() {
        _user = user;
      });
    });
  }

  Future<BaseUser> _getUser() async{
    return User(await Firestore.instance.collection("Users").document(widget.userId).get());
  }

  void _signOut() async{
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(e){
      print(e);
    }
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FeedPage();
      case 1:
        return new ProfileScreen(usuario: _user);
      case 2:
        return new GoalPage();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index){
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++){
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: ()=> _onSelectItem(i),
          )
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        actions: <Widget>[
          new FlatButton(
            onPressed: _signOut,
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
        )],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text(_user.nome), accountEmail: Text(_user.email)),
            new Column(children: drawerOptions)],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

}