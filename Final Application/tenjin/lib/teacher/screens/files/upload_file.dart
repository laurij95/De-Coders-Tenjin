import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/screens/documents/viewDocuments.dart';
import 'package:tenjin/teacher/screens/files/import_file.dart';
import 'package:tenjin/teacher/screens/files/import_students.dart';
import 'package:tenjin/teacher/screens/files/upload_grade.dart';
import 'package:tenjin/teacher/screens/home/teachcourses.dart';
import 'package:tenjin/teacher/screens/student/ViewStudents.dart';
import 'package:tenjin/teacher/screens/wrapper.dart';
import 'package:tenjin/teacher/service/courseServices.dart';
import 'package:tenjin/teacher/service/database.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'dart:io';


class uploadFiles extends StatefulWidget {
  @override
  _uploadFilesState createState() => _uploadFilesState();
}

class _uploadFilesState extends State<uploadFiles> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  String _displayName,_email;

  List<Course> _courses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String userid;
  File _file;
  String _fileName;

  @override
  void initState(){
    super.initState();
    userid;
    _courses = [];
    _scaffoldKey = GlobalKey();
    _getCourses(userid);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getCourses(userid));
  }

  //the getDisplayName(String uid) and getEmail (String uid) return the credentials of the authenticated user that is saved in Firestore

  getDisplayName (String uid) async {
    await _db.getInfo(uid).then((val){
      setState(() {
        _displayName = val;
      });
    });
  }

  getEmail (String uid) async {
      await _db.getEmailInfo(uid).then((val){
        if(mounted) {
          setState(() {
            _email = val;
          });
        }
      });
  }

  _getCourses(userid){
    // _showProgress('Loading Courses');
    CourseServices.getCourses(userid).then((courses){
      if(mounted) {
        setState(() {
          _courses = courses;
        }); //setState
        //_showProgress(widget.title);
      }
      print('Length ${courses.length}');
    });
  }

  SingleChildScrollView _dataBody(BuildContext context){
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
                    onPressed: () async{
                      String courseCode = course.coursecode.toUpperCase();
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => importFile(userid: userid, courseCode: courseCode)));},
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
      getEmail(userid);
    }
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Import Files'),
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
                        title: Text('Import Files Screen '),
                        content: const Text('This Screen is responsible for importing files for courses. You can start by selecting the up arrow to import a file to a course.', style: TextStyle(fontSize: 20),),
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
              accountEmail:new Text("$_email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),               currentAccountPicture: Icon(Icons.account_circle, size: 90),
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
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _dataBody(context),
            )
          ],
        ),
      ),
    );
  }
}