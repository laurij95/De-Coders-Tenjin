import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:tenjin/teacher/service/uploadServices.dart';


class importFile extends StatefulWidget {
  String courseCode, userid;
  importFile({this.userid, this.courseCode});
  @override
  _importFileState createState() => _importFileState(userid, courseCode);
}

class _importFileState extends State<importFile> {

  String courseCode, userid;
  _importFileState(this.userid, this.courseCode);

  File _file;
  String _fileName, _fileType;
  bool fileExists;
  bool ifImported = false;
  String fileInfo = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  Future<bool> _checkFile()async{
    try{
      _file = await FilePicker.getFile(type: FileType.custom, allowedExtensions: ['pdf']);
      if(await _file.exists()) {
        _fileName = context.basename(_file.path);
        _fileType = context.extension(_fileName);
      }
      if (_fileType == ".pdf")
        return true;
      else
        return false;
    }catch(e){
      print("Unsupported operation" + e.toString());
    }
  }

  uploadFiles(String userid, String courseCode, String filename, File file){
    if(mounted){
      UploadServices.uploadFile(userid, courseCode, _fileName, _file).then((result) {
        if ('success' == result)
          setState(() {
            ifImported = true;
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Import File'),
          backgroundColor: Colors.red[400],
          elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(children: <Widget>[
            SizedBox(height:140.0),
            ButtonTheme(
              minWidth: 250,
              height: 50,
              child:RaisedButton(
                shape: StadiumBorder(),
                color: Colors.red[400],
                child: Text('Select File'),
                onPressed: () async{
                  final fileExist = await _checkFile();
                  setState(() {
                    fileExists = fileExist;
                  });
                  if (fileExist){
                    setState(() { fileInfo = "File selected: $_fileName"; });
                  }
                  else {
                    print("Only type .pdf files allowed");
                  }
                },
              ),
            ),
            SizedBox(height:12.0),
            Text(
              fileInfo,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            SizedBox(height: 30.0),
            ButtonTheme(
              minWidth: 250,
              height: 50,
              child:RaisedButton(
                shape: StadiumBorder(),
                color: Colors.amber[400],
                child: Text('Upload'),
                onPressed: () async {
                  if (fileExists != null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                "Import file to course code: $courseCode ?"),
                            content: const Text(
                                "This imported file would be added to your course."),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: const Text('IMPORT'),
                                onPressed: () async {
                                  await uploadFiles(
                                      userid, courseCode, _fileName, _file);
                                  String message;
                                  if (ifImported)
                                    message = "File imported";
                                  else
                                    message = "File not imported";
                                  Navigator.of(context).pop();
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(content: Text("$message")));
                                },
                              )
                            ],
                          );
                        });
                  }
                },
              ),
            )
          ]
        ),
      ),
      )
    );
  }
}
