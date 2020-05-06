import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/screens/authenticate/sign_in.dart';
import 'package:tenjin/teacher/service/courseServices.dart';
import 'package:tenjin/teacher/service/uploadServices.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class uploadGrades extends StatefulWidget {
  @override
  _uploadGradesState createState() => _uploadGradesState();
}

class _uploadGradesState extends State<uploadGrades> {

  final AuthService _auth = AuthService();

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
                    onPressed: () async{
                      try{
                        _file = await FilePicker.getFile(type: FileType.custom, allowedExtensions: ['pdf']);
                        if(await _file.exists()) {
                          _fileName = context.basename(_file.path);
                          String courseCode = course.coursecode.toUpperCase();
                          UploadServices.uploadFile(userid, courseCode, _fileName, _file);
                        }
                      }catch(e){
                        print("Unsupported operation" + e.toString());
                      }
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