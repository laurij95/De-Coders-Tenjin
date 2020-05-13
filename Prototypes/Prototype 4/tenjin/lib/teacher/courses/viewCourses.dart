import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenjin/students/courses/course_details.dart';
//import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;

class Courses extends StatelessWidget{


  String Email;
  String username;
  Courses({this.Email,this.username});



  Future<List>getCourses() async{


    final response = await http.post("http://10.0.2.2/tenjindb/getcourses.php",
        body:{
          "Email":Email,
        });


    print(Email);

    var datauser = json.decode(response.body);

    Email=datauser[0]['Email'];

    return datauser;


/*

  final response = await http.get("http://10.0.2.2/tenjindb/getcourses.php");

    return json.decode(response.body);
    //var datauser = json.decode(response.body);
 */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.black,
            ),
          ),

          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.all(8),
                child: CircleAvatar(
                  // backgroundImage: NetworkImage,
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
        body: new FutureBuilder<List>(
            future: getCourses(),
            builder:(context,snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              return snapshot.hasData ? new ItemList(list: snapshot.data,username: username,Email: Email,)
                  : new Center(child: new CircularProgressIndicator(),);
            }
        )
    );
  }

}


class ItemList extends StatelessWidget {

  final List list;
  final String username;
  final String Email;
  ItemList({this.list,this.username,this.Email});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list==null ? 0: list.length,
      itemBuilder: (context, i){
        return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new CourseDetails(list: list, index: i,username: username,coursecode: list[i]['CourseID'],studEmail: Email,)
                  )
              ),
              child: new Card(
                child: new ListTile(
                  title: new Text(list[i]['CourseID']),
                  leading: new Icon(Icons.widgets),
                  subtitle: new Text( "Number of Credit Days: ${list[i]['Numofcredits']}"),
                ),
              ),
            )
        );
      },
    );
  }
}


