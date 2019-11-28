import 'package:flutter/material.dart';
import 'package:social_goal/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget{
  LoginPage({this.auth,this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn; //função que não possui parametros

  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage>{

  final formkey = GlobalKey<FormState>(); //chave do formulário
  String _email;
  String _password;
  String _username;
  String _birthDate;
  String _nacionalidade;
  FormType _formType = FormType.login; //indica se o usuário está logando ou registrando

  bool validateAndSave(){
    final form = formkey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  void validateAndSubmit() async{
    if (validateAndSave()){
      try{
        if (_formType == FormType.login){
          String userId = await widget.auth.signIn(_email, _password);
          print('Signed in: '+ userId);
        }
        else{
          String userId = await widget.auth.createUser(_email, _password);
          DocumentReference docRef = Firestore.instance.collection("Users").document(userId);
          await docRef.setData({
            'ProfilePicPath': "",
            'Nome': _username,
            'Nacionalidade': _nacionalidade,
            'Nascimento': _birthDate,
            'Email': _email,
            'Tags': null});
          print('Registered user: ${userId}');
        }
        widget.onSignedIn();
      }
      catch (e){
        print('Erro:  ${e}');
      }
    }
  }

  void moveToRegister(){
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }
  void moveToLogin(){
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: Center(
              child: new Text('Login',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
                key: formkey,
                child: ListView(
                    children: buildInputs() + buildSubmits()
                )
            )
        )
    );
  }

  List<Widget> buildInputs(){
    List<Widget> listinha =
    [TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value)=>value.isEmpty? 'Email can t be empty':null,
        onSaved: (value)=> _email = value
    ),
      TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value)=>value.isEmpty? 'Password can t be empty':null,
          onSaved: (value)=> _password = value
      ),];
    if (_formType == FormType.register){
      listinha.insertAll(0,
          [TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              validator: (value)=>value.isEmpty? 'Username can t be empty':null,
              onSaved: (value)=> _username = value
          ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Birth Date'),
                validator: (value)=>value.isEmpty? 'Birth Date can t be empty':null,
                onSaved: (value)=> _birthDate = value
            ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Nacionalidade'),
                validator: (value)=>value.isEmpty? 'Nacionalidade can t be empty':null,
                onSaved: (value)=> _nacionalidade = value
            ),]
      );
    }
    return listinha;
  }

  List<Widget> buildSubmits(){
    if (_formType == FormType.login){
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: new Text('Submit'),
          highlightColor: Theme.of(context).accentColor,
        ),
        FlatButton(
            onPressed: moveToRegister,
            child: new Text('Create an account')
        )
      ];
    }
    else{
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: new Text('Create an account'),
          highlightColor: Theme.of(context).accentColor,
        ),
        FlatButton(
            onPressed: moveToLogin,
            child: new Text('Have an account? Login')
        )
      ];
    }
  }
}

class TagsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _TagPageState();
  }
}
class _TagPageState extends State<TagsPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}