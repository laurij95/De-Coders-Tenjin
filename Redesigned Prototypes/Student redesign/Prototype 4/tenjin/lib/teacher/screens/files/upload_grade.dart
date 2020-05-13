import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/grades/credit_points.dart';
import 'package:tenjin/teacher/screens/wrapper.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/courseServices.dart';
import 'dart:io';

import 'package:tenjin/teacher/service/database.dart';

class uploadGrades extends StatefulWidget {

  @override
  _uploadGradesState createState() => _uploadGradesState();
}
class _uploadGradesState extends State<uploadGrades> {

  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  String _displayName = null;
  List<Course> _courses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String userid;

  @override
  void initState(){
    super.initState();
    userid;
    _courses = [];
    _scaffoldKey = GlobalKey();
    _getCourses(userid);
  }

  _getCourses(userid){
    // _showProgress('Loading Courses');
    CourseServices.getCourses(userid).then((courses){
      setState(() {
        _courses = courses;
      }); //setState
      print('Length ${courses.length}');
    });
  }

  getDisplayName (String uid) async {
    await _db.getInfo(uid).then((val){
      setState(() {
        _displayName = val;
      });
    });
  }

  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text(
                  'COURSE CODE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            DataColumn(
                label: Text(
                  'COURSE NAME',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            DataColumn(
                label: Text(
                    'UPLOAD',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )
                )
            )
          ],
          rows: _courses
              .map(
                  (course) => DataRow(cells: [
                DataCell(
                  Container(
                    width: 75,
                    child: Text(
                      course.coursecode.toUpperCase(),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: 120,
                    child: Text(
                      course.coursename.toUpperCase(),
                    ),
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(
                        Icons.file_upload
                    ),
                    onPressed: () async {
                      String courseCode = course.coursecode.toUpperCase();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => creditPoints(courseCode:courseCode)),
                      );
                    },
                  ),
                ),
              ])
          ).toList(),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      userid = _auth.getUserID(user);
      getDisplayName(userid);
    }
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
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh Contents',
            onPressed: (){
              _getCourses(userid);
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('HELLO, $_displayName'),
            Text("  "),
            Text(" Click the upload Icon to  to add student grades.  "),
            Text(" "),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
    );
  }
}