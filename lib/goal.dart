import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseGoal{
  String get imgPath;
  String get title;
  String get creatorName;
  String get creatorId;
  String get tag;
  String get description;
  int get likes;
  //TODO: Acidionar  1-Data de inicio e fim. 2-Nº de seguidores. 3- Nº de likes.  4-campo de img
}

class Goal implements BaseGoal{
  DocumentSnapshot _goal;
  Goal(DocumentSnapshot objetivo){
    this._goal = objetivo;
  }

  String get imgPath => _goal["ImgPath"];
  String get title => _goal["Title"];
  String get creatorName => _goal["CreatorName"];
  String get creatorId => _goal["CretorId"];
  String get tag => _goal["Tag"];
  String get description => _goal["Description"];
  int get likes => _goal["Likes"];
}