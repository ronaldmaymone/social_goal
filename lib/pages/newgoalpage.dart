import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewGoalPage extends StatefulWidget {
  final userId;
  final userName;
  NewGoalPage({this.userId, this.userName});

  @override
  _NewGoalPageState createState() => _NewGoalPageState();
}

class _NewGoalPageState extends State<NewGoalPage> {

  TextEditingController _labelController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String _tagPicked = "Escolha uma Tag";
  File _image;
  Map<String, dynamic> _newData =
  {"ImgPath": null,"Title": null,"CreatorName": null,"CreatorId": null,
  "Tag": null, "Description": null, "Likes": 0, "IniDate": null, "EndDate": null};

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  _saveLabelAndDesc() async{
    _newData["Title"] = _labelController.text;
    _newData["CreatorName"] = widget.userName;
    _newData["CreatorId"] = widget.userId;
    debugPrint(_tagPicked+" Was saved");
    _newData["Tag"] = _tagPicked;
    _newData["Description"] = _descriptionController.text;
    if (_image != null){
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(widget.userId + _newData["Title"]);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String temp = await firebaseStorageRef.getDownloadURL();
      setState(() {
        _newData['ImgPath'] = temp;
      });
      await Firestore.instance.collection("Goals").document().setData(_newData);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Tag picked = "+_tagPicked);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Novo Objetivo")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              child: SizedBox(
                width: 100,
                height: 150,
                child: (_image != null)?Image.file(_image, fit: BoxFit.fill):
                    RaisedButton(child: Text("Add Objective Image")
                        ,onPressed: getImage)
              ),
            ),
            Divider(),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                  labelText: "Título",
                  border: OutlineInputBorder()),
              controller: _labelController,
            ),
            Divider(),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Descrição completa do objetivo"),
              controller: _descriptionController,
            ),

            SizedBox(height: 5.0,),
            _startAndFinishPicker(context),
            SizedBox(height: 10.0,),
            DropdownButton<String>(
              hint: Text(_tagPicked),
              items: [
                DropdownMenuItem(
                  value: "Saúde",
                  child: Text(
                    "Saúde",
                  ),
                ),
                DropdownMenuItem(
                  value: "Educação",
                  child: Text(
                    "Educação",
                  ),
                ),
                DropdownMenuItem(
                  value: "Esporte",
                  child: Text(
                    "Esporte",
                  ),
                ),
                DropdownMenuItem(
                  value: "Games",
                  child: Text(
                    "Games",
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _tagPicked = value;
                });
              },
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    color: Colors.blue,
                    child: Text("Salvar"),
                    onPressed:() async {
                      await _saveLabelAndDesc();
                      Navigator.pop(context);
                    }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//Widget _tagPicker(String _tagPicked, BuildContext context){
//  return DropdownButton<String>(
//    hint: Text(_tagPicked),
//    items: [
//      DropdownMenuItem(
//        value: "Saúde",
//        child: Text(
//          "Saúde",
//        ),
//      ),
//      DropdownMenuItem(
//        value: "Educação",
//        child: Text(
//          "Educação",
//        ),
//      ),
//      DropdownMenuItem(
//        value: "Esporte",
//        child: Text(
//          "Esporte",
//        ),
//      ),
//      DropdownMenuItem(
//        value: "Games",
//        child: Text(
//          "Games",
//        ),
//      ),
//    ],
//    onChanged: (value) {
//      setState(() {
//        _tagPicked = value;
//      });
//    },
//
//  );
//}

Widget _startAndFinishPicker(BuildContext context){
  DateField _initialDate = DateField("Data Inicial");
  DateField _finalDate = DateField("Data Final");
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      _initialDate,
      SizedBox(height: 5.0,),
      _finalDate
    ],
  );
}

class DateField extends StatelessWidget {
  final String title;

  DateField(this.title);
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: title),
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }
}