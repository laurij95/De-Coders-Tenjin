import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/students.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/authenticate/sign_in.dart';
import 'package:tenjin/teacher/screens/student/ViewStudents.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/teacherServices.dart';

class ViewCourseStudents extends StatefulWidget {
  final coursecode;
  ViewCourseStudents({this.coursecode});

  @override
  _ViewCourseStudentsState createState() => _ViewCourseStudentsState(coursecode);
}

class _ViewCourseStudentsState extends State<ViewCourseStudents> {
  _ViewCourseStudentsState(this.coursecode);
  final AuthService _auth = AuthService();

  String coursecode;
  List<Student> _students;
  String userid;

  @override
  void initState(){
    super.initState();
    userid;
    coursecode;
    _students = [];
    _getStudents(coursecode);
  }

  _getStudents(coursecode){
    TeacherServices.getStudents(coursecode).then((students){
      setState(() {
        _students = students;
      });
      print('Length ${students.length}');
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
                'FIRST NAME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'LAST NAME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ], //columns
          rows: _students
              .map(
                  (student) => DataRow(cells:[
                DataCell(
                  Container(
                      width: 100,
                      child: Text(
                        student.fname.toUpperCase(),
                      )
                  ),
                ),
                DataCell(
                  Container(
                      width: 100,
                      child: Text(
                        student.lname.toUpperCase(),
                      )
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
             // await _auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh Contents',
            onPressed: (){
              print(coursecode);
              _getStudents(coursecode);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
            child: Container(

              child: _dataBody(),
            ),
          ),
        ],
      ),
    );
  }
}