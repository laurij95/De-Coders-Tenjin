import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/documents/viewCourseDocs.dart';
import 'package:tenjin/teacher/screens/files/import_students.dart';
import 'package:tenjin/teacher/screens/files/upload_file.dart';
import 'package:tenjin/teacher/screens/files/upload_grade.dart';
import 'package:tenjin/teacher/screens/home/teachcourses.dart';
import 'package:tenjin/teacher/screens/student/ViewStudents.dart';
import 'package:tenjin/teacher/screens/wrapper.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/courseServices.dart';
import 'package:tenjin/teacher/service/database.dart';

class ViewDocuments extends StatefulWidget {
  @override
  _ViewDocumentsState createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  String _displayName,_email;

  List<Course> _courses;
  String userid;

  @override
  void initState(){
    super.initState();
    userid;
    _courses = [];
    _getCourses(userid);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getCourses(userid));
  }

  //the getDisplayName(String uid) and getEmail (String uid) return the credentials of the authenticated user that is saved in Firestore

  getDisplayName (String uid) async {

      await _db.getInfo(uid).then((val){
        if(mounted) {
          setState(() {
            _displayName = val;
          });
        }
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

      CourseServices.getCourses(userid).then((courses){
        if(mounted) {
          setState(() {
            _courses = courses;
          });
          print('Length ${courses.length}');
        }
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
    if (user != null) {
      userid = _auth.getUserID(user);
      getDisplayName(userid);
      getEmail(userid);
    }
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Course Documents'),
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
                        title: Text('View Documents'),
                        content: const Text('This Screen is responsible for viewing files for by course. Select the file icon to view documents in desired course.', style: TextStyle(fontSize: 20),),
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
            SizedBox(height: 20.0),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
    );
  }
}