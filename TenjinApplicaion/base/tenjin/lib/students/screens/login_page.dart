import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tenjin/students/screens/MemberPage.dart';
import 'dart:convert';

import 'package:tenjin/students/screens/register_page.dart';
import 'package:tenjin/teacher/screens/wrapper.dart';

class LoginPage extends StatefulWidget{

  final Function toggleView;
  LoginPage({this.toggleView});


  @override
  _LoginPageState  createState()  => _LoginPageState();



}

class _LoginPageState extends State<LoginPage>
{

  String FirstName="",LastName="";
  String Email="";

 TextEditingController user =new  TextEditingController();
 TextEditingController pass = new TextEditingController();

 String msg='';

 Future<List>_login() async{

   final response = await http.post("http://10.0.2.2/tenjindb/login.php",
     body:{
        "username":user.text,
         "password":pass.text,
          "LastName":LastName,
     });

   print(response.body);

   var datauser = json.decode(response.body);

   if(datauser.length==0)
     {
          setState(() {
            msg="Login Fail";
          });
     }
   else
     {
       if(datauser[0]['level']=='member')
         {
           print("welcome member");
           Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => Member_page(FirstName: FirstName,LastName: LastName,Email: Email,username: user.text,)));

         }

          setState(() {
            FirstName=datauser[0]['FirstName'];
            LastName=datauser[0]['LastName'];
            Email=datauser[0]['Email'];
          });
     }

   return datauser;
 }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        elevation: 0.0,
        title: Text("Sign in to Tenjin"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_add),
            label:Text('Register'),
            onPressed: (){
             // widget.toggleView();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Username",style:TextStyle(fontSize: 18.0),),
              TextField(
                controller: user,
                decoration: InputDecoration(
                  hintText: 'Username'
                ),
              ),
              Text("Password",style:TextStyle(fontSize: 18.0),),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: (){
                  _login();
                },
              ),

              RaisedButton(
                child: Text("Role Screen "),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Wrapper()));
                },
              ),
              Text(msg, style: TextStyle(fontSize: 20.0,color: Colors.red),)
            ],
          )
        )
      ),
    );
  }

}