import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_goal/user.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.usuario});
  BaseUser usuario;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

enum TextEdit{
  nome,
  nacionalidade,
  nascimento,
  notEditting
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;
  Map<String, dynamic> _newData =
    {"ProfilePicPath": null,"Nome": null,"Nascimento": null,"Nacionalidade": null};
  TextEditingController _nameControl = TextEditingController();
  TextEditingController _nacionalidadeControl = TextEditingController();
  TextEditingController _nascimentoControl = TextEditingController();
  TextEdit _edit = TextEdit.notEditting;


  void _clearAllText(){
    _nameControl.clear();
    _nacionalidadeControl.clear();
    _nascimentoControl.clear();
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    void _update(BuildContext context) async{
      if (_image != null){
        StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(widget.usuario.id);
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        //widget.usuario.updateProfilePicPath(await firebaseStorageRef.getDownloadURL());
        String temp = await firebaseStorageRef.getDownloadURL();
        setState(() {
          _newData['ProfilePicPath'] = temp;
        });
      }
      widget.usuario.updateUser(_newData);
      setState(() {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('User Updated'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2)));
      });
    }

    return Scaffold(
      body: Builder(
          builder: (context) => Container(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.blue,
                        child: ClipOval(
                          child: SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (_image!=null)?Image.file(_image, fit: BoxFit.fill)
                                  :Image.network(widget.usuario.profilePicPath,
                                fit: BoxFit.fill,
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                          icon: Icon(
                              Icons.camera_alt,
                              size: 30.0
                          ),
                          onPressed: (){
                            getImage();
                          }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Nome", style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(width: 250,child:TextField(
                                controller: _nameControl,
                                decoration: InputDecoration(
                                  hintText: widget.usuario.nome,
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                enabled: _edit == TextEdit.nome?true:false,
                                onChanged: (newvalue){
                                  setState(() {
                                    _newData['Nome'] = newvalue;
                                  });
                                },
                              ))
                            ),
                          ],
                        )
                      )
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              setState(() {
                                _edit = TextEdit.nome;
                              });
                            }
                        )
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Nascimento", style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18.0)),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(width:250,child:TextField(
                                      controller: _nascimentoControl,
                                      decoration: InputDecoration(
                                        hintText: widget.usuario.nascimento,
                                        hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      enabled: _edit == TextEdit.nascimento?true:false,
                                      onChanged: (newvalue){
                                        setState(() {
                                          _newData['Nascimento'] = newvalue;
                                        });
                                      },
                                    ))
                                ),
                              ],
                            )
                        )
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              setState(() {
                                _edit = TextEdit.nascimento;
                              });
                            }
                        )
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Nacionalidade", style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18.0)),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(width:250,child:TextField(
                                      controller: _nacionalidadeControl,
                                      decoration: InputDecoration(
                                        hintText: widget.usuario.nacionalidade,
                                        hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      enabled: _edit == TextEdit.nacionalidade?true:false,
                                      onChanged: (newvalue){
                                        setState(() {
                                          _newData['Nacionalidade'] = newvalue;
                                        });;
                                      },
                                    ))
                                ),
                              ],
                            )
                        )
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              setState(() {
                                _edit = TextEdit.nacionalidade;
                              });
                            }
                        )
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Email',
                          style:
                          TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                      SizedBox(width: 10.0),
                      Text(widget.usuario.email,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: () => _clearAllText(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(width: 40),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: (){
                        _update(context);
                      },
                      child: Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}