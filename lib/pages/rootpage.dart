import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'package:social_goal/auth.dart';
import 'homepage.dart';
import 'package:social_goal/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}


enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  BaseUser _usuario;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user;
        }
        authStatus =
        user == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() async{
    widget.auth.currentUser().then((userid){
      setState(() {
        _userId = userid;
      });
    });
    _getUser().then((onValue){
      setState(() {
        _usuario = onValue;
      });
    });
    print("Nome do usuário: ${_usuario.nome}");
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
   //_getUser();
  }

  Future<BaseUser> _getUser() async{
    return User(await Firestore.instance.collection("Users").document(_userId).get());
    /*setState(() {
      _usuario = temp;
    });*/
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
            auth: widget.auth,
            user: _usuario,
            onSignedOut: _onSignedOut,
          );
        } else return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}
