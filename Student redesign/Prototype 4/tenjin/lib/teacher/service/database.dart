import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference courseCollection = Firestore.instance.collection('courses');
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String fname, String lname) async{
    return await userCollection.document(uid).setData({
      'Fname': fname,
      'Lname': lname,
    });
  }
  Future<String> getInfo(String uid) async{
    DocumentSnapshot snapshot = await userCollection.document(uid).get();
    String dp = getDisplayName(snapshot);
    return dp;
  }

  String getDisplayName(DocumentSnapshot snapshot){
    String dp = snapshot.data['Fname'];
    return dp;
  }

  Future updateData(selectedDocument, newValues){
    Firestore.instance.collection('courses').document(selectedDocument).updateData(newValues).catchError((e){
      print (e);
    });
  }

  bool isLoggedIn(){
    if (FirebaseAuth.instance.currentUser()!= null) {
      return true;
    } else {
      return false;
    }
  }

  //add a course to the collection
  Future<void> addCourse(course) async {
    if(isLoggedIn()){
      Firestore.instance.collection('courses').add(course).catchError((e){
        print(e);
      });
    }else{
      print('You need to be logged in');
    }
  }

  //list of brews from a snapshot
  List<Course>_courseListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Course(
        userid: doc.data['uid'] ?? '',
        coursecode: doc.data['courseCode'] ?? '',
        coursename: doc.data['courseName'] ?? '',
      );
    }).toList();
  }

  // Course _courseDataFromSnapshot(DocumentSnapshot snapshot){
  //   return Course(
  //     uid: uid,
  //     courseCode: snapshot.data['courseCode'],
  //     courseName: snapshot.data['courseName'],
  //     courseDescription: snapshot.data['courseDescription'],
  //   );
  // }

  //get course stream
  Stream <List<Course>> get courses {
    return courseCollection.snapshots()
        .map(_courseListFromSnapshot);
  }

//get user doc stream
// Stream<Course> get course{
//   return courseCollection.document(uid).snapshots()
//     .map(_courseDataFromSnapshot);
// }
}