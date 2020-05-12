import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:tenjin/teacher/screens/documents/viewDocuments.dart';

class documentMaterial extends StatefulWidget {

  String Names, coursecode;

  documentMaterial({this.Names,this.coursecode});

  @override
  _documentMaterialState createState() => _documentMaterialState();
}

class _documentMaterialState extends State<documentMaterial> {
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

  //the function retrieves the document url in the sql table based on the document name selected
  loadfile() async {
    if(mounted){
      url = await fetchUrl();
      document = await PDFDocument.fromURL("$url");
      setState(() {
        document = document;
      });
    }
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
              MaterialPageRoute(builder: (context) => ViewDocuments()),
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
              : PDFViewer(document: document, showPicker: false, indicatorBackground: Colors.red[300], ),
        ),
      ),
    );
  }
}