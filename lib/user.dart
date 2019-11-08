import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class BaseUser{
  String get profilePicPath;
  String get id;
  String get nome;
  String get nacionalidade;
  String get email;
  String get Nascimento;

  void updateProfilePicPath(String path);
  void editNome(String newNome);
  void editNacionalidade(String newNacionalidade);
  void editEmail(String newEmail);
  void editNascimento(String newNascimento);
}
class User implements BaseUser{
   //Future<DocumentSnapshot> _usuario;
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
  String get Nascimento => _usuario['Nascimento'];

  void updateProfilePicPath(String path) async{
    Map<String, dynamic> data = _usuario.data;
    data['ProfilePicPath'] = path;
    await _usuario.reference.updateData(data);
  }
  //O Usuario edita seus dados
  void editNome(String newNome) async{
    Map<String, dynamic> data = _usuario.data;
    data['Nome'] = newNome;
    await _usuario.reference.updateData(data);
  }
  void editNacionalidade(String newNacionalidade) async{
    Map<String, dynamic> data = _usuario.data;
    data['Nacionalidade'] = newNacionalidade;
    await _usuario.reference.updateData(data);
  }
  void editEmail(String newEmail) async{
    Map<String, dynamic> data = _usuario.data;
    data['Email'] = newEmail;
    await _usuario.reference.updateData(data);
  }
  void editNascimento(String newNascimento) async{
    Map<String, dynamic> data = _usuario.data;
    data['Nascimento'] = newNascimento;
    await _usuario.reference.updateData(data);
  }
}