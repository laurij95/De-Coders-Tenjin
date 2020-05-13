import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/shared/constants.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/documents/viewDocuments.dart';
import 'package:tenjin/teacher/screens/files/import_students.dart';
import 'package:tenjin/teacher/screens/files/upload_file.dart';
import 'package:tenjin/teacher/screens/files/upload_grade.dart';
import 'package:tenjin/teacher/screens/student/ViewStudents.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/courseServices.dart';
import 'package:tenjin/teacher/service/database.dart';
import 'package:tenjin/teacher/screens/wrapper.dart';
import 'package:tenjin/teacher/service/importStudents.dart';

class CourseHome extends StatefulWidget {

  CourseHome():super();
  final String title = 'Courses';

  @override
  CourseHomeState createState() => CourseHomeState();
}

class CourseHomeState extends State<CourseHome> {

  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  String _displayName, _email;
  List<Course> _courses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _coursecodeController;
  TextEditingController _coursenameController;
  Course _selectedCourse;
  bool _isUpdating;
  String _titleProgress;
  String userid;

  @override
  void initState() {
    super.initState();
    userid;
    _courses = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // to get the context to show the snackbar
    _coursecodeController = TextEditingController();
    _coursenameController = TextEditingController();
    _getCourses(userid);
    _createTable();


    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getCourses(userid));
  }


  _showProgress(String message){
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _createTable(){
    //_showProgress('Creating Table');
    CourseServices.createTable().then((result){
      print(result);
      if ('success' == result) {
        //_showSnackBar(context, result);
        //_showProgress(widget.title);
      }
    });
  }

  _getCourses(userid){
    _showProgress('Loading Courses');
    CourseServices.getCourses(userid).then((courses){
      setState(() {
        _courses = courses;
      }); //setState
      _showProgress(widget.title);
      print('Length ${courses.length}');
    });

  }

  _addCourse(String userid){
    if(_coursecodeController.text.isEmpty && _coursenameController.text.isEmpty){
      print('Empty Fields');
      return;
    }else{
      _showProgress('Adding Course...');
      CourseServices.addCourse(_coursecodeController.text, _coursenameController.text, userid).then((result){
        if ('success' == result) {
          _getCourses(userid);
          _clearValues();
        }
      });
    }
  }

  _updateCourse(Course course){
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Courses');
    CourseServices.updateCourse(course.courseid, _coursecodeController.text, _coursenameController.text).then((result){
      if ('success' == result) {
        _getCourses(userid);
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteCourse(Course course){
    _showProgress('Deleting Course...');
    CourseServices.deleteCourse(course.courseid).then((result){
      if('success' == result){
        _getCourses(userid);
      }
    });
  }
  //clearValues
  _clearValues(){
    _coursecodeController.text = '';
    _coursenameController.text = '';
  }

  _showValues(Course course){
    _coursecodeController.text = course.coursecode;
    _coursenameController.text = course.coursename;
  }

  //the getDisplayName(String uid) and getEmail (String uid) return the credentials of the authenticated user that is saved in Firestore

  getDisplayName (String uid) async {
    await _db.getInfo(uid).then((val) {
      setState(() {
        _displayName = val;
      });
    });
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
                'DELETE',
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
                  onTap: (){
                    _showValues(course);
                    _selectedCourse = course;
                    setState(() {
                      _isUpdating = true;
                    });//setState
                  },
                ),
                DataCell(
                  Container(
                      width: 120,
                      child: Text(
                        course.coursename.toUpperCase(),
                      )
                  ),
                  onTap: (){
                    _showValues(course);
                    _selectedCourse = course;
                    setState(() {
                      _isUpdating = true;
                    });//setState
                  },
                ),
                DataCell(
                  IconButton(
                    icon: Icon(
                        Icons.delete
                    ),
                    onPressed: (){
                      showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button for close dialog!
                          builder: (BuildContext context){
                            return AlertDialog(
                                title: Text('Delete Course?'),
                                content: const Text(
                                    'This action is irreversible. Select Yes to confirm.'),
                                actions: <Widget>[
                                    FlatButton(
                                      child: const Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                       child: const Text('Yes'),
                                       onPressed: () {
                                        _deleteCourse(course);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                            ]
                            );
                          }
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
      getEmail(userid);

    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text(_titleProgress),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.info),
            onPressed: (){
              return showDialog(
                context: context,
                //barrierDismissible: false,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text('Courses Screen'),
                    content: const Text('This Screen is responsible for creating, updating and deleting courses. You can start by creating a course below.', style: TextStyle(fontSize: 20),),
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
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Create a new Course",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _coursecodeController,
                decoration: tenjinInputDecoration.copyWith(hintText: 'COURSE CODE EG. COMP2505'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _coursenameController,
                decoration: tenjinInputDecoration.copyWith(hintText: 'COURSE NAME EG. COMPUTER PROGRAMMING 2'),
              ),
            ),
            _isUpdating
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    child: Text('UPDATE'),
                    onPressed: (){
                      return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Warning!!'),
                            content: const Text('Updating the details of a course after content has been linked to it may result in potential loss of data.'),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: const Text('UPDATE'),
                                onPressed: () {
                                  _updateCourse(_selectedCourse);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(width: 8.0,),
                  RaisedButton(
                    color: Colors.amber,
                    child: Text('CANCEL'),
                    onPressed: (){
                      setState(() {
                        _isUpdating = false;
                      });
                      _clearValues();
                    },
                  ),
                ],
              ),
            )
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    child: Text('Submit'),
                    onPressed: (){
                      return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('Add course?'),
                              content: const Text('This course would be added to your account.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: const Text('CANCEL'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: const Text('ADD'),
                                  onPressed: () {
                                    _addCourse(userid);
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: _dataBody(context),
            )
          ],
        ),
      ),
    );
  }
}