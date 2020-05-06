import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/authenticate/sign_in.dart';
import 'package:tenjin/teacher/screens/documents/viewCourseDocs.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/courseServices.dart';

class ViewDocuments extends StatefulWidget {
  @override
  _ViewDocumentsState createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {
  final AuthService _auth = AuthService();

  List<Course> _courses;
  String userid;

  @override
  void initState(){
    super.initState();
    userid;
    _courses = [];
    _getCourses(userid);
  }

  _getCourses(userid){
    CourseServices.getCourses(userid).then((courses){
      setState(() {
        _courses = courses;
      });
      //print('Courses is: $_courses');
      print ('Length ${courses.length}');
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
                'VIEW DOCS',
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
                      width: 100,
                      child: Text(
                        course.coursename.toUpperCase(),
                      )
                  ),
                ),
                DataCell(
                  Container(
                    width: 75,
                    child: IconButton(
                      icon: Icon(
                          Icons.description
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewCourseDocs(coursecode: course.coursecode)),
                        );
                      },
                    ),
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
              //await _auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
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