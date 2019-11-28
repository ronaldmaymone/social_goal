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
            'Tags': null,
            'FollowedGoals': []});
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
              child: new Text(_formType == FormType.login ? 'Login' : 'Registrar',
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
        validator: (value)=>value.isEmpty? 'Email não pode estar vazio':null,
        onSaved: (value)=> _email = value
    ),
      TextFormField(
          decoration: InputDecoration(labelText: 'Senha'),
          obscureText: true,
          validator: (value)=>value.isEmpty? 'Senha não pode estar vazio':null,
          onSaved: (value)=> _password = value
      ),];
    if (_formType == FormType.register){
      listinha.insertAll(0,
          [TextFormField(
              decoration: InputDecoration(labelText: 'Nome de Usuário'),
              validator: (value)=>value.isEmpty? 'Nome de usário não pode estar vazio':null,
              onSaved: (value)=> _username = value
          ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Nascimento'),
                validator: (value)=>value.isEmpty? 'Nascimento não pode estar vazio':null,
                onSaved: (value)=> _birthDate = value
            ),
            TextFormField(
                decoration: InputDecoration(labelText: 'Nacionalidade'),
                validator: (value)=>value.isEmpty? 'Nacionalidade não pode estar vazio':null,
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
          child: new Text('Enviar'),
          highlightColor: Theme.of(context).accentColor,
        ),
        FlatButton(
            onPressed: moveToRegister,
            child: new Text('Criar Conta')
        )
      ];
    }
    else{
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: new Text('Criar Conta'),
          highlightColor: Theme.of(context).accentColor,
        ),
        FlatButton(
            onPressed: moveToLogin,
            child: new Text('Já possui uma conta? Login')
        )
      ];
    }
  }
}
