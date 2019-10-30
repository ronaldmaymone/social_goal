import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseUser{
  String get nome;
  String get nacionalidade;
  String get email;
  String get Nascimento;

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
  String get nome => _usuario['Nome'];
  String get nacionalidade => _usuario['Nacionalidade'];
  String get email => _usuario['Email'];
  String get Nascimento => _usuario['Nascimento'];

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