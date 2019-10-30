import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth{
  Future<String> signIn(String email, String password);
  Future<String> createUser(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}


class Auth implements BaseAuth{
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async{
    AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  Future<String> createUser(String email, String password) async{
    AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  Future<String> currentUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user==null ? null : user.uid;
  }

  Future<void> signOut() async{
    return FirebaseAuth.instance.signOut();
  }
}