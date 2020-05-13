import 'package:flutter/material.dart';
import 'package:tenjin/teacher/screens/addCourse/addCourse.dart';

class AddCourseForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Text(
          'Add Course Form',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView( //deals with overflow issue, do not remove
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
          child: AddCourse(),
        ),
      ),
    );
  }
}
