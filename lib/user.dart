import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseUser{
  String get profilePicPath;
  String get id;
  String get nome;
  String get nacionalidade;
  String get email;
  String get nascimento;
  List<dynamic> get tags;
  List<dynamic> get followedGoals;

  void updateUser(Map<String, dynamic> newData);
}
class User implements BaseUser{
  DocumentSnapshot _usuario;

  User(DocumentSnapshot usuario){
    this._usuario = usuario;
  }

  //Getters
  String get profilePicPath => _usuario['ProfilePicPath'];
  String get id => _usuario.reference.documentID;
  String get nome => _usuario['Nome'];
  String get nacionalidade => _usuario['Nacionalidade'];
  String get email => _usuario['Email'];
  String get nascimento => _usuario['Nascimento'];
  List<dynamic> get tags => _usuario['Tags'];
  List<dynamic> get followedGoals => _usuario["FollowedGoals"];

  void addGoal(String doc) async{
    Map<String, dynamic> data = _usuario.data;
    data["FollowedGoals"] = new List.from(_usuario["FollowedGoals"]);
    data["FollowedGoals"].add(doc);
    await _usuario.reference.updateData(data);
  }

  void editTags(List<dynamic> tags) async{
    Map<String,dynamic> data = _usuario.data;
    data['Tags'] = tags;
    await _usuario.reference.updateData(data);
  }

  //Atualiza o Usuario no  BD
  void updateUser(Map<String, dynamic> newData) async{
    Map<String, dynamic> data = _usuario.data;
    if (newData['Nome'] != null){
      data['Nome'] = newData['Nome'];
    }
    if (newData['Nascimento'] != null){
      data['Nascimento'] = newData['Nascimento'];
    }
    if (newData['Nacionalidade'] != null){
      data['Nacionalidade'] = newData['Nacionalidade'];
    }
    if (newData['ProfilePicPath'] != null){
      data['ProfilePicPath'] = newData['ProfilePicPath'];
    }
    await _usuario.reference.updateData(data);
  }
}