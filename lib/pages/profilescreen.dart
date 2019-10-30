import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:social_goal/user.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.usuario});
  BaseUser usuario;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;

  @override
  Widget build(BuildContext context) {

    Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Picture Uploaded')));
      });
    }

    return Scaffold(
      body: Builder(
          builder: (context)=>Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20,),
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
                                  :Image.network(
                                'https://images-na.ssl-images-amazon.com/images/I/81-yKbVND-L._SY355_.png',
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
                SizedBox(height: 10,),
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
                              child: Text('Username',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.usuario.nome,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          Icons.edit,
                          color: Colors.lightBlueAccent,
                        ),
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
                              child: Text('Nascimento',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.usuario.Nascimento,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          Icons.edit,
                          color: Colors.lightBlueAccent,
                        ),
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
                              child: Text('Nacionalidade',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.usuario.nacionalidade,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          Icons.edit,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: (){
                        Navigator.of(context).pop;
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(width: 40,),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: (){
                        uploadPic(context);
                      },
                      child: Text(
                        'Submit',
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