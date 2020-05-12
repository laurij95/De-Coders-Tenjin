
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/shared/constants.dart';
import 'package:tenjin/teacher/models/courses.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/authenticate/sign_in.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/courseServices.dart';

import '../../service/database.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class CourseHome extends StatefulWidget {

  CourseHome():super();
  final String title = 'Tenjin';

  @override
  CourseHomeState createState() => CourseHomeState();
}

class CourseHomeState extends State<CourseHome> {

  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();


  List<Course> _courses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _coursecodeController;
  TextEditingController _coursenameController;
  Course _selectedCourse;
  bool _isUpdating;
  String _titleProgress;

  String userid;

  @override
  void initState(){
    super.initState();
    userid;
    _courses = [];
    _isUpdating= false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // to get the context to show the snackbar
    _coursecodeController = TextEditingController();
    _coursenameController = TextEditingController();
    _getCourses(userid);
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
  String _displayName;
  getDisplayName (String uid) async {
    await _db.getInfo(uid).then((val){
      setState(() {
        _displayName = val;
      });
    });
  }

  _createTable(){
    _showProgress('Creating Table');
    CourseServices.createTable().then((result){
      print(result);
      if ('success' == result) {
        _showSnackBar(context, result);
        _showProgress(widget.title);
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
      // CourseServices.checkForDuplicates(_coursecodeController.text, _coursenameController.text).then((result){
      // print(result);
      // String message = 'These values already exist, please type different values';
      //   if('error' == result){
      _showProgress('Adding Course...');
      CourseServices.addCourse(_coursecodeController.text, _coursenameController.text, userid).then((result){
        if ('success' == result) {
          _getCourses(userid);
          _clearValues();
        }
      });
      // }else{
      //   _showSnackBar(context, message);
      //   _showProgress(widget.title);
      //   _clearValues();
      //   return;
      // }
      // });
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


  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context, Course course) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Course ?'),
          content: const Text(
              'Are you sure you want to delete!!. This Action cannot be undone '),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                _deleteCourse(course);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: const Text('You are going to update!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                _updateCourse(_selectedCourse);
                //   Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<ConfirmAction> _submbitconfirm(BuildContext context, String userid) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sumbit Course?'),
          content: const Text(
              ' You are about to submit '),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                //_deleteCourse(course);
                _addCourse(userid);
                print(userid);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
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
                      // _deleteCourse(course);
                      //code would go here
                      _asyncConfirmDialog(context,course);

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
      key: _scaffoldKey,
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text(_titleProgress),
        backgroundColor: Colors.amber[400],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_upward),
            tooltip: 'Initialise Course Table',
            onPressed: () {
              Text("Creating Table");
              print('Creating table');
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.note_add),
            tooltip: 'Add course file',
            onPressed: (){
              _submbitconfirm(context,userid);
              //_addCourse(userid);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh Contents',
            onPressed: (){
              _getCourses(userid);
            },
          ),
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
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('HELLO, $_displayName'),
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
                    color: Colors.amber,
                    child: Text('UPDATE'),
                    onPressed: (){
                      // _updateCourse(_selectedCourse);
                      _ackAlert(context);
                    },
                  ),
                  SizedBox(width: 8.0,),
                  RaisedButton(
                    color: Colors.redAccent,
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
                    color: Colors.amber,
                    child: Text('Submit'),
                    onPressed: (){

                      _submbitconfirm(context,userid);
                   //   _addCourse(userid);
                    //  print(userid);
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     _addCourse(userid);
      //      print(userid);
      //   },
      //   child:Icon(Icons.add),
      // ),
    );
  }
}