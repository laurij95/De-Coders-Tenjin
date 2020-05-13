import'package:flutter/material.dart';
import 'package:tenjin/students/Profile/profile_screen.dart';
import 'package:tenjin/students/screens/login_page.dart';
//import 'package:tenjin/students/screens/testuploadpractice.dart';
import 'package:tenjin/teacher/courses/viewCourses.dart';

class Member_page extends StatelessWidget{

  final String FirstName,LastName,Email,username;
  Member_page({this.FirstName,this.LastName,this.Email,this.username});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text('Welcome $FirstName',style: TextStyle(fontSize: 14.0),),
        backgroundColor: Colors.amber[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async{
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Profile'),
            onPressed: () async{
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(FirstName: FirstName,LastName: LastName, Email: Email)));
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            //avatar,
            //description,
            RaisedButton(
              child: Text('view Courses'),
              onPressed: (){
                Text("Pressed");
                print(username);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Courses(Email: Email,username: username,)));
              },
            ),

          ],
        ),
      ),
    );
  }


}