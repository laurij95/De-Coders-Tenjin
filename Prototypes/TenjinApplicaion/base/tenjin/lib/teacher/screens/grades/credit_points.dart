import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tenjin/teacher/screens/authenticate/sign_in.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:tenjin/teacher/service/gradeServices.dart';

class creditPoints extends StatefulWidget {
  String courseCode;
  creditPoints({this.courseCode});

  @override
  _creditPointsState createState() => _creditPointsState(courseCode);
}

class _creditPointsState extends State<creditPoints> {

  String courseCode;
  _creditPointsState(this.courseCode);

  final AuthService _auth = AuthService();

  String _fileName;
  String _fileType;
  String fileInfo = "";
  List<String> _info = new List<String>();
  File _file;
  String passRate;
  bool isnum, fileExists;


  Future<bool> _checkFile()async{
    try{
      _file = await FilePicker.getFile(type: FileType.any);
      if(await _file.exists()) {
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
  void _uploadPoints(String passrate) async {

    try{
      if(await _file.exists()) {
        Stream<List> inputStream = _file.openRead();
        int counter = 0;  //since i did not find a way to skip the header, the counter variable is used to count if the header has been counted in already. when counter is zero nothing is done

        inputStream
            .transform(utf8.decoder)       // Decode bytes to UTF-8.
            .transform(new LineSplitter()) // Convert stream to individual lines.
            .listen((String line) {        // Process results.

          List row = line.split(','); // split by comma

          int passMark = int.parse(passrate);

          String fname = row[0];
          String lname = row[1];
          String idNum = row[2];
          String email = row[5];
          String mark = row[6];


          if(counter != 0){
            bool checkMark = isNumeric(mark);
            if(checkMark){
              double doubleMark = double.parse(mark);
              int markNum = doubleMark.round();
              print('$email, $courseCode, $markNum, $passMark');
              if(markNum > passMark)
                GradeServices.uploadPoints(email, courseCode, 'one');
              else
                GradeServices.uploadPoints(email, courseCode, 'zero');
            }
            GradeServices.uploadPoints(email, courseCode, 'zero');
          }


          counter = counter + 1;
        },
            onDone: () { print('File is now closed.'); },
            onError: (e) { print(e.toString()); });
      }
    }catch(e){
      print("Unsupported operation" + e.toString());
    }
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text('Tenjin'),
        backgroundColor: Colors.amber[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async{
             // await _auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text(
                    'Select File'
                ),
                onPressed: () async{
                  final fileExist = await _checkFile();
                  setState(() {
                    fileExists = fileExist;
                  });
                  if (fileExist){
                    //_openFileExplorer(context);
                    setState(() { fileInfo = "File selected: $_fileName"; });
                  }
                  else {
                    print("didnt choose csv file");
                  }
                },
              ),
              SizedBox(height:12.0),
              Text(
                fileInfo,
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
              TextFormField(
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                      hintText: 'Enter digits only',
                      labelText: 'Pass rate'
                  ),
                  validator: (val) => val.isEmpty ?'Enter pass rate' : null,
                  onChanged: (val) {
                    setState(() => passRate = val);
                  }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text(
                    'Upload'
                ),
                onPressed: () async{
                  if( passRate.isNotEmpty && fileExists != null){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Add credit points to students accounts?'),
                            content: const Text(
                                'This will take the imported data and add credit points appropriately.'),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: const Text('UPLOAD'),
                                onPressed: () {
                                  _uploadPoints(passRate);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        }
                    );
                  }
                  else
                    print('fields missing values');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}