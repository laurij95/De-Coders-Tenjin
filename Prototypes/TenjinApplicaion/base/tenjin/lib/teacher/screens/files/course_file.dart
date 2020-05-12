import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/service/courseServices.dart';
import 'package:tenjin/teacher/screens/files/student_file.dart';
import 'package:tenjin/teacher/screens/authenticate/sign_in.dart';

class CourseFile extends StatefulWidget {
  @override
  _CourseFileState createState() => _CourseFileState();
}

class _CourseFileState extends State<CourseFile> {

  List<Course> _courses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  Course _selectedCourse;
  TextEditingController _coursecodeController;
  TextEditingController _coursenameController;

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
      //_showProgress(widget.title);
      print('Length ${courses.length}');
    });
  }

  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
              ),
            ),
            DataColumn(
              label: Text(
                'COURSE NAME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'UPLOAD',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ], //columns
          rows: _courses
              .map(
                  (course) => DataRow(cells:[
                DataCell(
                  Container(
                      width: 75,
                      child: Text(
                        course.coursecode.toUpperCase(),
                      )
                  ),
                ),
                DataCell(
                  Container(
                      width: 120,
                      child: Text(
                        course.coursename.toUpperCase(),
                      )
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(
                        Icons.file_upload
                    ),
                    onPressed: (){
                      String courseCode = course.coursecode.toUpperCase();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentFile(courseCode:courseCode)),
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
    userid = user.uid;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text("Import Students"),
        backgroundColor: Colors.amber[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async{
              // await _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
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
            Text('HELLO, $userid'),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
    );
  }
}