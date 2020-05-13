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
  final _formKey = GlobalKey<FormState>();

  String FirstName="",LastName="";
  String Email="";

 //TextEditingController user =new  TextEditingController();
 //TextEditingController pass = new TextEditingController();

 String msg='';

 String username= ' ';
  String password = '';

 Future<List>_login() async{

   final response = await http.post("http://10.0.2.2/tenjindb/login.php",
     body:{
        "username":username,
         "password":password,
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
               MaterialPageRoute(builder: (context) => Member_page(FirstName: FirstName,LastName: LastName,Email: Email,username: username,)));

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
        backgroundColor: Colors.amber[300],
        elevation: 0.0,
        title: Text("Sign in to Tenjin", style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_add),
            label:Text('Register'),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));

            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Username'
                      ),
                      validator: (val) => val.isEmpty ?'Enter your Username' : null,
                      onChanged: (val){
                        setState(() => username = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Password'
                      ),
                      obscureText: true,
                      validator: (val) => val.length < 7? 'Enter your password ': null,
                      onChanged: (val){
                        setState(() => password = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () {
                      _login();
                    },
                    color: Colors.amber[300],
                    textColor: Colors.black87,
                    child: const Text('Sign-In'),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  ),

                  SizedBox(height:12.0),

                  Text(msg, style: TextStyle(fontSize: 20.0,color: Colors.red),)
                ],
              ),
            ),
          )
      ),
    );

  }

}