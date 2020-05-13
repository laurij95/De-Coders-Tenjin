import 'package:tenjin/students/courses/course_details.dart';
import 'package:flutter/material.dart';


class CourseMaterial extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text('Course Material'),
        backgroundColor: Colors.amber[400],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),

    );
  }

}