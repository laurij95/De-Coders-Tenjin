import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tenjin/students/screens/MemberPage.dart';
import 'dart:convert';

import 'package:tenjin/students/screens/login_page.dart';

class RegisterPage extends StatefulWidget{

  final Function toggleView;
  RegisterPage({this.toggleView});


  @override
  _RegisterPageState  createState()  => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{

  TextEditingController user =new  TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController FirstName =new  TextEditingController();
  TextEditingController LastName = new TextEditingController();
  TextEditingController Email =new  TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String msg="";

  //String username="";


  Future<List>_signin() async{
    var url="http://10.0.2.2/tenjindb/register.php";
       
    http.post(url,body:{
      "username": user.text,
      "password": pass.text,
      "FirstName": FirstName.text,
      "LastName": LastName.text,
      "Email":Email.text,

    });

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()));
        
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
          backgroundColor: Colors.amber[400],
          elevation: 0.0,
          title: Text("Create an account"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label:Text('Sign In'),
              onPressed: (){
                widget.toggleView();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ]
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          children:<Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      controller: user,
                      decoration: const InputDecoration(
                          labelText: 'Enter Username', hintText: "Username"
                      ),

                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      controller: FirstName,
                      decoration: const InputDecoration(
                          labelText: 'Enter First name',  hintText: "FirstName"
                      ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      controller: LastName,
                      decoration: const InputDecoration(
                          labelText: 'Enter Last name',  hintText: "LastName"
                      ),

                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: Email,
                      decoration: const InputDecoration(
                          labelText: 'Enter Email',  hintText: "Enter Username"
                      ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      controller: pass,
                      decoration: const InputDecoration(
                          labelText: ' Enter Password',  hintText: "Enter"
                      ),
                      obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.orangeAccent[400],
                      child: Text(
                        'Create account',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _signin();
                       // Navigator.pop(context);

                      }
                  ),
                  SizedBox(height:12.0),
                ],
              ),
            )
          ]
      ),
    );
  }

}

