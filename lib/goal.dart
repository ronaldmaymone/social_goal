import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseGoal{
  String get title;
  String get creator;
  String get tag;
  String get description;
}

class Goal implements BaseGoal{
  DocumentSnapshot goal;

  String get title => goal["title"];
  String get creator => goal["creator"];
  String get tag => goal["tag"];
  String get description => goal["description"];
}