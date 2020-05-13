import 'package:flutter/material.dart';
import 'package:tenjin/teacher/screens/authenticate/sign_in.dart';
import 'package:tenjin/teacher/service/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  String FirstName;
  Register({this.toggleView, this.FirstName});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //store values logging in
  //text field state
  String email = '';
  String password = '';
  String fname = '';
  String lname = '';
  String error = '';

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
                      decoration: const InputDecoration(
                          labelText: 'First name'
                      ),
                      validator: (val) => val.isEmpty ?'Enter your first name' : null,
                      onChanged: (val){
                        setState(() => fname = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Last name'
                      ),
                      validator: (val) => val.isEmpty ?'Enter your last name' : null,
                      onChanged: (val){
                        setState(() => lname = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email'
                      ),
                      validator: (val) => val.isEmpty ?'Enter your email' : null,
                      onChanged: (val){
                        setState(() => email = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password'
                    ),
                      obscureText: true,
                      validator: (val) => val.length < 7? 'Enter a password 7+ chars long' : null,
                      onChanged: (val){
                        setState(() => password = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.orangeAccent[400],
                    child: Text(
                      'Create account',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        dynamic result = await _auth.registerWithEandP(email, password);
                        if (result == null){
                          setState(() {
                            error = 'Please supply proper information';
                          });
                        }
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    }
                  ),
                  SizedBox(height:12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
          )
        ]
      ),
    );
  }
}
