import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenjin/teacher/screens/documents/viewDocuments.dart';
import 'package:tenjin/teacher/screens/files/import_students.dart';
import 'package:tenjin/teacher/screens/files/upload_file.dart';
import 'package:tenjin/teacher/screens/files/upload_grade.dart';
import 'package:tenjin/teacher/screens/home/teachcourses.dart';
import 'package:tenjin/teacher/screens/student/ViewStudents.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/screens/wrapper.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text('Tenjin'),
        backgroundColor: Colors.amber[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async{
              await _auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
            },
          )
        ],
      ),
      body: ListView(
        padding:  EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: <Widget>[
          Text("Make sure courses are assigned to you.",style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
          Text("Select To Course Form to add courses", textAlign: TextAlign.center,),
          Text(" "),

          RaisedButton(
            color: Colors.orangeAccent[400],
            child: Text(
              'Import Student Database',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => importStudents()),
              );
            },
          ),
          RaisedButton(
            color: Colors.orangeAccent[400],
            child: Text(
              'To courses Form',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseHome()),
              );
            },
          ),

          RaisedButton(
            color: Colors.orangeAccent[400],
            child: Text(
              'Import files',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => uploadFiles()),
              );
            },
          ),
          RaisedButton(
            color: Colors.orangeAccent[400],
            child: Text(
              'Upload grades',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => uploadGrades()),
              );
            },
          ),
          RaisedButton(
            color: Colors.orangeAccent[400],
            child: Text(
              'View Documents',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewDocuments()),
              );
            },
          ),
          RaisedButton(
            color: Colors.orangeAccent[400],
            child: Text(
              'View Students',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewStudents()),
              );
            },
          ),
        ],
      ),
    );
  }
}