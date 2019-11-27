import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseGoal{
  String get title;
  String get creator;
  String get tag;
  String get description;
  //TODO: Acidionar  1-Data de inicio e fim. 2-Nº de seguidores. 3- Nº de likes.  4-campo de img
}

class Goal implements BaseGoal{
  DocumentSnapshot _goal;
  Goal(DocumentSnapshot objetivo){
    this._goal = objetivo;
  }

  String get title => _goal["title"];
  String get creator => _goal["creator"];
  String get tag => _goal["tag"];
  String get description => _goal["description"];
}