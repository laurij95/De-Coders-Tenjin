import 'package:firebase_auth/firebase_auth.dart';
import 'package:tenjin/teacher/models/user.dart';

import 'database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  User _userFromFireBaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }

  //sign in with email and password
  Future signInWithEandP(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      return null;
    }
  }

  String getUserID(User uid){
    String userID = uid.uid;
    return userID;
  }

  //register with email and password
  Future registerWithEandP(String fname, String lname, String email, String password) async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(fname, lname, email);
      return _userFromFireBaseUser(user);
    }catch(e){
      return null;
    }
  }
  //sign out
  Future signOut() async{
      try {
        return await _auth.signOut();
      }catch(e){
        return null;
      }
  }
}