import 'package:flutter/material.dart';
import 'package:social_goal/user.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class TagSelectionPage extends StatefulWidget {
  final User user;
  TagSelectionPage({this.user});

  @override
  _TagSelectionPageState createState() => _TagSelectionPageState();
}

class _TagSelectionPageState extends State<TagSelectionPage> {
  List _userTags;
//  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userTags = [];     // TODO: Aqui ao invés de criar uma vazia ele busca do firebase, e deixa vazia caso venha null
//    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        //TODO: Implementar aqui o salvamento no Firebase da lista _userTags.  Usa esse print ai pra testar
//        _myActivitiesResult = _userTags.toString();
      for(String _tags in _userTags){
        debugPrint(_tags);
      }
      });
    }
  }

  _deleteTags(){
    //TODO: Como ao tentar salvar uma lista vazia de tags ele nao permite, aqui a gnt deleta as Tags do usuário se ele quiser
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tags"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: false,
                  titleText: 'Minhas Tags',
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Selecione pelo menos 1 Tag!';
                    }
                  },
                  dataSource: [
                    {
                      "display": "Educação",
                      "value": "Educação",
                    },
                    {
                      "display": "Saúde",
                      "value": "Saúde",
                    },
                    {
                      "display": "Esporte",
                      "value": "Esporte",
                    },
                    {
                      "display": "Game",
                      "value": "Game",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  // required: true,
                  hintText: 'Você ainda não selecionou nenhuma Tag',
                  value: _userTags,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _userTags = value;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text('Salvar Tags'),
                  onPressed: _saveForm,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text('Deletar Tags'),
                  onPressed: _deleteTags,
                ),
              ),
//              Container(
//                padding: EdgeInsets.all(16),
//                child: Text(_myActivitiesResult),
//              )
            ],
          ),
        ),
      ),
    );
  }
}
