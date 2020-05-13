import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/students.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/documents/viewDocuments.dart';
import 'package:tenjin/teacher/screens/files/import_students.dart';
import 'package:tenjin/teacher/screens/files/upload_file.dart';
import 'package:tenjin/teacher/screens/files/upload_grade.dart';
import 'package:tenjin/teacher/screens/home/teachcourses.dart';
import 'package:tenjin/teacher/screens/wrapper.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/database.dart';
import 'package:tenjin/teacher/service/teacherServices.dart';
import 'ViewStudents.dart';

class ViewCourseStudents extends StatefulWidget {
  final coursecode;
  ViewCourseStudents({this.coursecode});

  @override
  _ViewCourseStudentsState createState() => _ViewCourseStudentsState(coursecode);
}

class _ViewCourseStudentsState extends State<ViewCourseStudents> {
  _ViewCourseStudentsState(this.coursecode);
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  String _displayName,_email;

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

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getStudents(coursecode));
  }

  //the getDisplayName(String uid) and getEmail (String uid) return the credentials of the authenticated user that is saved in Firestore
  getDisplayName (String uid) async {
    if(mounted){
      await _db.getInfo(uid).then((val){
        setState(() {
          _displayName = val;
        });
      });
    }
  }
  getEmail (String uid) async {
    if(mounted){
      await _db.getEmailInfo(uid).then((val){
        setState(() {
          _email = val;
        });
      });
    }
  }

  _getStudents(coursecode){
    if(mounted){
      TeacherServices.getStudents(coursecode).then((students){
        setState(() {
          _students = students;
        });
        print('Length ${students.length}');
      });
    }
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
    if (user != null) {
      userid = _auth.getUserID(user);
      getDisplayName(userid);
    }
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Students'),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
              child: Icon(Icons.info),
              onPressed: (){
                return showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('View Students'),
                        content: const Text('This Screen is responsible for viewing students in a course.', style: TextStyle(fontSize: 20),),
                      );
                    }
                );
              }
          )
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: new Text("$_displayName", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              accountEmail:new Text("$_email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),              currentAccountPicture: Icon(Icons.account_circle, size: 90),
              decoration: BoxDecoration(color: Colors.red[400]),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Import Students'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => importStudents()));
              },
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text('Courses'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CourseHome()));
              },
            ),
            ListTile(
              leading: Icon(Icons.file_upload),
              title: Text('Import Files'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => uploadFiles()));
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_turned_in),
              title: Text('Upload Grades'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => uploadGrades()));
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('View Documents'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewDocuments()));
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('View Students'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewStudents()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
              },
            ),
          ],
        ),
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