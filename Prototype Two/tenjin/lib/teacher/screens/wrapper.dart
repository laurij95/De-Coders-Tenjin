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
    if(user == null){
      return Scaffold(
        appBar: AppBar(
            title: Text('Select Role')
        ),
        body: Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      child: Text('Teacher'),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> Authenticate())
                        );
                      }
                  ),

                  RaisedButton(
                    child: Text('Student'),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>  LoginPage()));
                    },
                  ),
                ]
            )
        ) ,
      );
    } else{
      return Home();
    }
  }

}
/*
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }

}

 */