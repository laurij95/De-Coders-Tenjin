import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tenjin/students/courses/course_material.dart';
import 'package:tenjin/teacher/courses/viewCourses.dart';

class CourseDetails extends StatefulWidget {

  List list;
  int index;
  CourseDetails({this.index,this.list});


  @override
  _CourseDetailsState createState() => new _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {

  @override
  Widget build(BuildContext) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['CourseID']}"),
        backgroundColor: Colors.amber[400],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Card(
              child: new Center(
                child: new Column(
                  children: <Widget>[
                  /* new Text(widget.list[widget.index]['coursename'],
                      style: new TextStyle(fontSize: 20.0),),*/
                    /*new Text("Description : ${widget.list[widget
                        .index]['Course_Desc']}"
                      , style: new TextStyle(fontSize: 20.0),)*/

                    new Padding(padding: const EdgeInsets.only(top: 30.0),),

                  ],
                ),
              )
          )
      ),
    );
  }
}