import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tenjin/students/Profile/profile_screen.dart';
import 'package:tenjin/students/screens/MemberPage.dart';

class EditnamePage extends StatefulWidget
{

  final Function toggleView;
 EditnamePage({this.toggleView});
//  final List list;
 // final int index;

 // EditnamePage({this.list, this.index});

  @override
  _EditnamePageState createState() => new _EditnamePageState();

}

class _EditnamePageState extends State<EditnamePage>
{
  TextEditingController prevuser =new  TextEditingController();
  TextEditingController user =new  TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController FirstName =new  TextEditingController();
  TextEditingController LastName = new TextEditingController();
  TextEditingController Email =new  TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String msg="";

  //String username="";


  Future<String>_editData() async{

    final response = await http.post('http://10.0.2.2/tenjindb/editdata.php',
        body:{
          "prevusername": prevuser.text,
          "username": user.text,
          "password": pass.text,
          "FirstName": FirstName.text,
          "LastName": LastName.text,
          "Email":Email.text,
        });

    if(200 == response.statusCode){
      // return response.body;
      print(response.body);
    }else{
      // return "error";
      print("error");
    }

/*
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()));
*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: new AppBar(
          title: new Text("EDIT DATA"),
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
                    controller: prevuser,
                    decoration: const InputDecoration(
                        labelText: 'Enter previous Username', hintText: "previous Username"
                    ),

                  ),
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
                    child: new Text("EDIT DATA"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      _editData();
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context)=>new Member_page(FirstName: FirstName.text,LastName: LastName.text,Email: Email.text,)
                          )
                      );
                    },
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