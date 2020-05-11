import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection(
      'users');

  Future updateUserData(String fname, String lname, String email) async {
    return await userCollection.document(uid).setData({
      'Fname': fname,
      'Lname': lname,
      'email': email,
    });
  }

  Future<String> getInfo(String uid) async {
    DocumentSnapshot snapshot = await userCollection.document(uid).get();
    if (snapshot != null) {
      String dp = getDisplayName(snapshot);
      return dp;
    }
    return "";
  }

  String getDisplayName(DocumentSnapshot snapshot) {
    String fname = snapshot.data['Fname'];
    String lname = snapshot.data['Lname'];

    String displayName = fname + " " + lname;
    return displayName;
  }

  Future<String> getEmailInfo(String uid) async {
    DocumentSnapshot snapshot = await userCollection.document(uid).get();
    if (snapshot != null) {
      String dp = getEmail(snapshot);
      return dp;
    }
    return "";
  }

  String getEmail(DocumentSnapshot snapshot) {
    String email = snapshot.data['email'];

    return email;
  }

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }
}