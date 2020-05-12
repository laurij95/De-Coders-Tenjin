import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String _fileName, _fileType;
  String fileInfo = "";
  File _file;
  String passRate = "";
  bool isnum, fileExists;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
            onDone: () { print('Assigning credit points to students is completed.'); },
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Upload Grades'),
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
                        title: Text('Upload Grades Screen'),
                        content: const Text('To Upload Grade: select File, set pass rate and then select the Upload button. Please note pass rate and file can not be empty.', style: TextStyle(fontSize: 20),),
                      );
                    }
                );
              }
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height:140.0),
                ButtonTheme(
                  minWidth: 250,
                  height: 50,
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    color: Colors.red[400],
                    child: Text(
                        'Select File'
                    ),
                    onPressed: () async{
                      final fileExist = await _checkFile();
                      setState(() {
                        fileExists = fileExist;
                      });
                      if (fileExist){
                        setState(() { fileInfo = "File selected: $_fileName"; });
                      }
                      else {
                        print("didnt choose csv file");
                      }
                    },
                  ),

                ),
                SizedBox(height:12.0),
                Text(
                  fileInfo,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                TextFormField(
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        hintText: 'Enter digits only',
                        labelText: 'Pass rate'
                    ),
                    validator: (val) => val.isEmpty ?'Enter pass rate' : "",
                    onChanged: (val) {
                      setState(() => passRate = val);
                    }
                ),
                SizedBox(height: 20.0),
                ButtonTheme(
                  minWidth: 250,
                  height: 50,
                  child:RaisedButton(
                    shape: StadiumBorder(),
                    color: Colors.amber[400],
                    child: Text('Upload'),
                    onPressed: () async{
                      if( fileExists != false && passRate?.isNotEmpty ?? false ){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('Add credit points to students accounts for course code: $courseCode?'),
                                content: const Text(
                                    'This will take the imported grade data and add credit points to students accordingly.'),
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
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(content: Text("Grades Uploaded")));
                                    },
                                  )
                                ],
                              );
                            }
                        );
                      }
                      else
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text("Fields missing values")));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}