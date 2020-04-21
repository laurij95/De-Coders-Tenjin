import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/screens/files/course_file.dart';
import 'package:tenjin/teacher/screens/home/teachcourses.dart';
import 'package:tenjin/teacher/service/auth.dart';

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
            },
          )
        ],
      ),
      body: ListView(
        padding:  EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: <Widget>[
          RaisedButton(
            color: Colors.orangeAccent[400],
            child: Text(
              'Import Student Database',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseFile()),
              );
            },
          ),
          RaisedButton(
            color: Colors.orangeAccent[400],
            child: Text(
              'To courses',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseHome()),
              );
            },
          ),
        ],


      ),
    );
  }
}