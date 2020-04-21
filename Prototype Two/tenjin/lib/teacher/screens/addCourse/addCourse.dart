import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/service/database.dart';

class AddCourse extends StatefulWidget {
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  //global key that uniquely identifies form widget
  final _formkey = GlobalKey<FormState>();

  DatabaseService dbuser = DatabaseService();

  String courseName = '';
  String courseCode = '';
  String courseDescription = '';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    String uid = user.uid.toString();

    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //@TODO: add in non-editable fields for userid and courseid
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('User ID: $uid',
              style: TextStyle(
                backgroundColor: Colors.amber[300],
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            'Course Code',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              letterSpacing: 1.0,
            ),
          ),
          // SizedBox(height: 5.0),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter a course code (eg. CHEM1120)',
            ),
            validator: (value){
              if(value.isEmpty){
                return 'Please enter a course code';
              }
              return null;
            },
            onChanged: (value){
              setState(() {
                this.courseCode = value;
              });
            },
          ),
          SizedBox(height: 30.0),
          Text(
            'Course Name',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              letterSpacing: 1.0,
            ),
          ),
          // SizedBox(height: 5.0),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter a course name (eg. Chemistry Basics)',
            ),
            validator: (value){
              if(value.isEmpty){
                return 'Please enter a course name';
              }
              return null;
            },
            onChanged: (value){
              setState(() {
                this.courseName = value;
              });
            },
          ),
          SizedBox(height: 30.0),
          Text(
            'Course Description',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              letterSpacing: 1.0,
            ),
          ),
          // SizedBox(height: 5.0),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter a brief description',
            ),
            validator: (value){
              if(value.isEmpty){
                return 'Please enter a course description';
              }
              return null;
            },
            onChanged: (value){
              setState(() {
                this.courseDescription = value;
              });
            },
          ),
          SizedBox(height: 30),
          RaisedButton(
            onPressed: () async {
              if (_formkey.currentState.validate()){
                Map <String,dynamic> course = { //we map the details to a course object
                  'uid': user.uid,
                  'courseCode': this.courseCode,
                  'courseName': this.courseName,
                  'courseDescription': this.courseDescription,
                };
                await dbuser.addCourse(course); //insert le object into le database
                print('course successfully added');
                Scaffold //snackbar is like a notification bar situated at the bottom of the screen
                    .of(context)
                    .showSnackBar(SnackBar(
                    backgroundColor: Colors.deepOrangeAccent,
                    content:
                    Text('New Course Successfully Submitted',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                )
                );
                Future.delayed(Duration(seconds: 2),(){ //delays the transition to the home screen
                  Navigator.pop(context); //sends your tail back to the home screen
                });
              }
            },
            color: Colors.amber[400],
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}