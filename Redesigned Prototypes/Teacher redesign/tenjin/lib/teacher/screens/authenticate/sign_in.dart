import 'package:flutter/material.dart';
import 'package:tenjin/teacher/screens/home/home.dart';
import 'package:tenjin/teacher/service/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //store values logging in - text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        title: Text("Sign in to Tenjin"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_add),
            label:Text('Register'),
            onPressed: (){
              widget.toggleView();
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
                        labelText: 'Email',
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
                  color: Colors.redAccent[400],
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: StadiumBorder(),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      dynamic result = await _auth.signInWithEandP(email, password);
                      if (result == null){
                        setState(() => error = 'Could not sign in with those credentials');
                      }
                      else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                    }
                  },
                ),
                SizedBox(height:12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}