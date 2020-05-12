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
    return new MaterialApp(
      home: new Scaffold(
       // backgroundColor: Colors.amber[300],
        appBar: AppBar(
          title: Text('Welcome $FirstName',style: TextStyle(fontSize: 20.0,color: Colors.black)),
         // backgroundColor: Colors.amber[400],
          backgroundColor: Colors.amber[300],
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

        body: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: [const Color(0xFFFFF8E1),const Color(0xFFFFF8E1)],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp
              ),
            ),

            width: double.infinity,


              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,


                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text('Click to View your Courses',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                textBaseline: TextBaseline.alphabetic

                            ),),

                          ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            children: <Widget>[
                              //avatar,
                              //description,
                              Center(
                                child: RaisedButton(
                                  onPressed: () {
                                    Text("Pressed");
                                    print(username);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Courses(Email: Email,username: username,)));

                                  },
                                  color: Colors.amber[300],
                                  textColor: Colors.black87,
                                  child: const Text('View Courses'),

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                                ),
                              ),
                            ],


                          )




                        ],


                          )
                           )
                         )

                        ],
                      ),


                  ),


            ),


          );

  }


}