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
       // backgroundColor: Colors.amber[5],

        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.black,
            ),
          ),

          backgroundColor: Colors.amber[300],
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(

          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [const Color(0xFFFFF8E1), const Color(0xFFFFF8E1)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
            ),
          ),
          child: new FutureBuilder<List>(
              future: getCourses(),
              builder:(context,snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData ? new ItemList(list: snapshot.data,username: username,Email: Email,)
                    : new Center(child: new CircularProgressIndicator(),);
              }
          ),
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
      itemBuilder: (context, i)
      {
        return new Container(
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                offset: Offset(0, 0),
                blurRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: InkWell(
                highlightColor: Colors.white.withAlpha(50),
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new CourseDetails(
                            list: list,
                            index: i,
                            username: username,
                            coursecode: list[i]['CourseID'],
                            studEmail: Email,)
                      )
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        'images/$i.PNG',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(


                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            list[i]['CourseID'].toUpperCase(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),

                          Divider(
                            color: Colors.grey[300],
                            height: 25,
                          ),
                          Text(
                            "Number of Credit Points: ${list[i]['Numofcredits']}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
