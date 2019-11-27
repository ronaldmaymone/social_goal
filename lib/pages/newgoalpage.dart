import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class NewGoalPage extends StatefulWidget {
  final ValueChanged<List<Widget>> notifyUpdate;
  final List<Widget> goalList;

  const NewGoalPage({Key key, this.notifyUpdate, this.goalList}) : super(key: key);


  @override
  _NewGoalPageState createState() => _NewGoalPageState();
}

class _NewGoalPageState extends State<NewGoalPage> {
  TextEditingController _labelController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String _label;
  String _description;

  _saveLabelAndDesc() async{
    _label = _labelController.text;
    debugPrint(_label);
    _description = _descriptionController.text;
    debugPrint(_description);
    widget.goalList.add(_goalWidget(_label, _description));
    debugPrint("Len inside new goal = "+widget.goalList.length.toString());
    widget.notifyUpdate(widget.goalList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true
        ,title: Text("Novo Objetivo"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
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
            SizedBox(height: 5.0,),
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

Widget _goalWidget(String label, String desc){
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
    child: Column(
      children: <Widget>[
        Image.asset("assets/images/sucess_image.jpg"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),   //TEXT LABEL FROM CONTROLLER ABOVE
              Divider(),
              Text(desc)  // TEXT DESCRIPTION FROM ABOVE
            ],
          ),
        )
      ],
    ),
  );
}

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
  String title;

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