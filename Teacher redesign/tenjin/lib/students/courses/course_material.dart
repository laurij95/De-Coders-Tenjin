import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
//import 'dart.io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:tenjin/students/screens/MemberPage.dart';
import 'package:tenjin/students/screens/login_page.dart';



class CourseMaterial extends StatefulWidget {

  String Names;
  String coursecode;

  CourseMaterial({this.Names,this.coursecode});

  @override
  _CourseMaterialState createState() => _CourseMaterialState();


}


class _CourseMaterialState extends State<CourseMaterial> {


  PDFDocument document;


  String CourseCode;
  String url;
  bool _loading;

  Future<String> fetchUrl() async {
    print(widget.coursecode);

    final response = await http.post('http://10.0.2.2/tenjindb/geturl.php',
        body: {
          "Coursecode": widget.coursecode,
          "Name": widget.Names,


        });
    var datauser = json.decode(response.body);

    CourseCode = datauser[0]['course_id'];
    url = datauser[0]['file_url'];

    // print(url);
    return url;
  }

  double _progressValue;

  @override
  void initState() {
    super.initState();

    _loading = false;
    _progressValue = 0.0;

    loadfile();
  }


  loadfile() async {
    url = await fetchUrl();
    print("Url is $url");


    document = await PDFDocument.fromURL("$url");


    setState(() {
      document = document;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Document'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),

      ),


      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _loading
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                value: _progressValue,
              ),
              Text('${(_progressValue * 100).round()}%'),

            ],
          )
              : PDFViewer(document: document, showPicker: false, indicatorBackground: Colors.blue,),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _loading = !_loading;
            _updateProgress();

          });

        },
        //child: PDFViewer(document: document),
        tooltip: 'Download',
        child: Icon(Icons.add_to_home_screen),
      ),
    );
  }

  // we use this function to simulate a download
  // by updating the progress value
  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          PDFViewer(document: document);
          _loading = false;
          t.cancel();
          _progressValue:
          0.0;

          return;
        }
      });
    });
  }
}
