import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tenjin/students/courses/course_material.dart';
import 'package:tenjin/teacher/models/documents.dart';
import 'package:tenjin/teacher/service/studentServices.dart';
import 'package:http/http.dart' as http;

class CourseDetails extends StatefulWidget {

  List list;
  int index;
  String username;
  String coursecode;
  String studEmail;
  CourseDetails({this.index,this.list,this.username,this.coursecode,this.studEmail});



  @override
  _CourseDetailsState createState() => new _CourseDetailsState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _CourseDetailsState extends State<CourseDetails> {
  List<Document> _documents;
  String coursecode;

  @override
  void initState(){
    super.initState();
    coursecode;
    _documents = [];
    _getDocuments(coursecode);
  }

  _getDocuments(coursecode){
    StudentServices.getDocuments(coursecode).then((documents){
      setState(() {
        _documents = documents;
      });
      print('Length ${documents.length}');
    });
  }

  String numcred;
  String id;
 // String coursecode;
  String Email;



  Future<String> _Alert() async {

    final response = await http.post('http://10.0.2.2/tenjindb/alertcreditdays.php',
        body: {
          "CourseCode": widget.coursecode
        }  );


    print(response.body);

    var datauser = json.decode(response.body);

    print(datauser);

    print(datauser.length);

    if(datauser.length==0)
    {
      print("zero");
      return "false";
    }
    else
    {
      print("filled");
      numcred=datauser[0]['Numofcredits'];
      Email=datauser[0]['Email'];
      coursecode=datauser[0]['CourseID'];

      print(numcred);
     // print(id);
      print(coursecode);

    //  print(id);

      /* if(Email == 'mattcy@live.com')
            {
              print("this is a true statement");
              return "true";
            }*/
      return "true";

    }

  } //end of Alert

  Future <String>  _updateData() async {
    final response = await http.post('http://10.0.2.2/tenjindb/subtractcreditday.php',
        body:{
          // "StudentID":username,
          "Email":widget.studEmail,
          "Coursecode":widget.coursecode,


        });
    //print(username);
    //  print(coursecode);

    if(200 == response.statusCode){
      // return response.body;
      print(response.body);
      //var datauser=response.body;

    }else{
      // return "error";
      print("error");
    }

    //  check= json.decode(response.body);

  }

  // enum ConfirmAction { CANCEL, ACCEPT }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context, String Name, ) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation to use credit days'),
          content: const Text(
              'Are you willing to pay for a credit day'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () async {
                // Navigator.of(context).pop(ConfirmAction.ACCEPT);


                final val = await _Alert();
                // ignore: unrelated_type_equality_checks
                print(val);

                if(val =="false")
                {
                  _updateData();
                  //print("CourseCode is: $");
                  //_Alert();
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new CourseMaterial(Names: Name,coursecode: widget.coursecode,)
                      )
                  );
                }
                else
                {
                  _ackAlert(context);
                 // print("something else");
                }


              },
            )
          ],
        );
      },
    );
  }

  Future<void> _ackAlert(BuildContext context) {


    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Credit Days'),
          content: const Text('You Have No more Credit Days'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'COURSE CODE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'DOCUMENT NAME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'UNLOCK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ], //columns
          rows: _documents
              .map(
                  (document) => DataRow(cells:[
                DataCell(
                  Container(
                      width: 75,
                      child: Text(
                        document.courseid.toUpperCase(),
                      )
                  ),
                ),
                DataCell(
                  Container(
                      width: 100,
                      child: Text(
                        document.fileName.toUpperCase(),
                      )
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.redAccent,
                    ),
                    onPressed: (){
                      //unlock functionality goes here
                      _asyncConfirmDialog(context,document.fileName);
                      //_updateData();
                    },
                  ),
                ),
              ])
          ).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(
          title: Text("${widget.list[widget.index]['CourseID']}"),
          backgroundColor: Colors.amber[400],
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh Contents',
              onPressed: (){
                print(widget.list[widget.index]['CourseID'].toString());
                _getDocuments(widget.list[widget.index]['CourseID'].toString());
              },
            ),
          ],
        ),
        body:Container(
          child: _dataBody(),
        )

    );
  }
}