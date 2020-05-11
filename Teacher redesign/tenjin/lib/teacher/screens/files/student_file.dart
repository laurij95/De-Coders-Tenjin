import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:tenjin/teacher/service/importStudents.dart';


class StudentFile extends StatefulWidget {
  String courseCode;
  StudentFile({this.courseCode});


  @override
  _StudentFileState createState() => _StudentFileState(courseCode);
}

class _StudentFileState extends State<StudentFile> {
  String courseCode;
  _StudentFileState(this.courseCode);
  String _fileName, _fileType;
  List<String> info = new List<String>();
  String fileInfo = "";
  File _file;
  bool fileExists = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //this void function receives data from the csv file, line by line , excluding the first row (headers) and adding them to the database
  void createRecord(List l) async{
    ImportStudents.addStudent(courseCode, l[0], l[1], l[2]);
  }

  //this boolean function checks the type of file the user selects and returns true or false based on this
  Future<bool> _checkFile()async{
    try{
      _file = await FilePicker.getFile(type: FileType.any);
      if(await _file != null) {
        _fileName = context.basename(_file.path);
        _fileType = context.extension(_fileName);
      }
      if (_fileType == ".csv")
        return true;
      else
        return false;
    }catch(e){
      print("Unsupported operation" + e.toString());
    }

  }

  //after the file is checked out to be a csv file, this file reads the file and splits it line by line into a List
  void _openFileExplorer(BuildContext context) async {
    try{
      if(await _file.exists()) {
        _file.openRead().map(utf8.decode).transform(new LineSplitter()).forEach((l) => info.add(l));
        _asyncConfirmDialog(context);
      }
    }catch(e){
      print("Unsupported operation" + e.toString());
    }
  }

  void addTodb(BuildContext context){
    var temp;

    List<String> tempList = info;

    //to remove the header of the csv file
    tempList.removeAt(0);
    print(tempList);

    for (String s in tempList){
      temp = new List(3);
      temp = s.split(',');
      createRecord(temp);
    }
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Students imported.")));
    info.clear();
  }

  void _asyncConfirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add students to course code: $courseCode?'),
          content: const Text(
              'This will take the imported data and add students. Select Add to continue'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('ADD'),
              onPressed: () {
                addTodb(context);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  //alert dialog shown if user does not select a .csv file
  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Please ensure that a file with a .csv extension is selected to import students"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Upload Student File'),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
              child: Icon(Icons.info),
              onPressed: (){
                return showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Import Students Screen '),
                        content: const Text('This Screen is responsible for importing students to a course. Please ensure that this is an exported .csv file from a myElearning course student list.', style: TextStyle(fontSize: 20),),
                      );
                    }
                );
              }
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
              children: <Widget>[
                SizedBox(height:140.0),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: ButtonTheme(
                    minWidth: 250,
                    height: 50,
                    child:  RaisedButton(
                      onPressed: () async{
                        fileExists = await _checkFile();
                        print(fileExists);
                        if (!fileExists)
                          _showDialog(context);
                        else{
                          setState(() {
                            fileInfo = "File selected: $_fileName";
                          });

                        }
                      },
                      child: new Text("Open file picker"),
                      color: Colors.red[400],
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
                SizedBox(height:12.0),
                Text(
                  fileInfo,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: ButtonTheme(
                    minWidth: 250,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () async{
                        if (fileExists) {
                          _openFileExplorer(context);
                        }
                        else
                          _showDialog(context);
                      },
                      child: new Text("Import Students"),
                      color: Colors.amber[400],
                      shape: StadiumBorder(),
                    ),
                  )
                ),
              ]),
        ),
      ),
    );
  }
}