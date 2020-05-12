import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/authenticate/authenticate.dart';
import 'package:tenjin/teacher/screens/home/home.dart';
import 'package:tenjin/students/screens/login_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.orange[900],
                      Colors.orange[800],
                      Colors.orange[400],
                    ]
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80,),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/tenjin-2.png', height: 100, width: 100,),
                        SizedBox(height: 10,),
                        Text("Select Role",
                          style: TextStyle(color: Colors.white, fontSize: 30),),
                        SizedBox(height: 100,),
                        ButtonTheme(
                          minWidth: 250,
                          height: 50,
                          buttonColor: Colors.white,
                          child: RaisedButton(
                              child: Text('Teacher', style: TextStyle(fontSize: 20),),
                              shape: StadiumBorder(),
                              elevation: 8,
                              highlightElevation: 2,
                              textColor: Colors.red[500],
                              highlightColor: Colors.red[500],
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Authenticate())
                                );
                              }
                          ),
                        ),
                        SizedBox(height: 50,),
                        ButtonTheme(
                          minWidth: 250,
                          height: 50,
                          buttonColor: Colors.white,
                          child: RaisedButton(
                            child: Text('Student',style: TextStyle(fontSize: 20),),
                              shape: StadiumBorder(),
                              //color: Colors.amber[500],
                              elevation: 8,
                              highlightElevation: 2,
                              textColor: Colors.amber[500],
                              highlightColor: Colors.amber[500],
                              onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>  LoginPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    } else{
      return Home();
    }
  }
}