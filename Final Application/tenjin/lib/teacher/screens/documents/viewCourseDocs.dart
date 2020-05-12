import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/shared/constants.dart';
import 'package:tenjin/teacher/models/documents.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/documents/documentMaterial.dart';
import 'package:tenjin/teacher/screens/documents/viewDocuments.dart';
import 'package:tenjin/teacher/screens/files/import_students.dart';
import 'package:tenjin/teacher/screens/files/upload_file.dart';
import 'package:tenjin/teacher/screens/files/upload_grade.dart';
import 'package:tenjin/teacher/screens/home/teachcourses.dart';
import 'package:tenjin/teacher/screens/student/ViewStudents.dart';
import 'package:tenjin/teacher/screens/wrapper.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/database.dart';
import 'package:tenjin/teacher/service/documentServices.dart';

class ViewCourseDocs extends StatefulWidget {

  final coursecode;
  ViewCourseDocs({this.coursecode});

  @override
  _ViewCourseDocsState createState() => _ViewCourseDocsState(coursecode);
}

class _ViewCourseDocsState extends State<ViewCourseDocs> {
  _ViewCourseDocsState(this.coursecode);
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  String _displayName, _email;

  Document _selectedDocument;
  List<Document> _documents;
  TextEditingController _coursecodeController;
  TextEditingController _filenameController;
  String userid;
  String coursecode;
  bool _isUpdating;

  @override
  void initState(){
    super.initState();
    userid;
    coursecode;
    _documents = [];
    _isUpdating = false;
    _coursecodeController = TextEditingController();
    _filenameController = TextEditingController();
    _getDocuments(userid, coursecode);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getDocuments(userid, coursecode));
  }

  //the getDisplayName(String uid) and getEmail (String uid) return the credentials of the authenticated user that is saved in Firestore

  getDisplayName (String uid) async {
    if(mounted){
      await _db.getInfo(uid).then((val){
        setState(() {
          _displayName = val;
        });
      });
    }
  }
  getEmail (String uid) async {

      await _db.getEmailInfo(uid).then((val){
        if(mounted) {
          setState(() {
            _email = val;
          });
        }
      });

  }

 String _getDocuments(userid, coursecode){
      DocumentServices.getDocuments(userid, coursecode).then((documents){
        if(mounted) {
          setState(() {
            _documents = documents;
          });
        }
        print('Length ${documents.length}');
      });

  }

  //updates the document in the database based on document id #number
  //the user can update the coursecode and document name

  _updateDocument(Document document){
    if(mounted){
      setState(() {
        _isUpdating = true;
      });
      DocumentServices.updateDocument(document.id, _coursecodeController.text,_filenameController.text).then((result){
        if ('success' == result) {
          _getDocuments(userid,coursecode);
          setState(() {
            _isUpdating = false;
          });
          _clearValues();
        }
      });
    }

  }

  //deletes the document in the database based on document id #number
  _deleteDocument(Document document){
    if(mounted){
      DocumentServices.deleteDocument(document.id).then((result){
        if('success' == result){
          _getDocuments(userid,coursecode);
        }
      });
    }
  }

  _clearValues(){
    _coursecodeController.text = '';
    _filenameController.text = '';
  }

  _showValues(Document document){
    _coursecodeController.text = document.courseid;
    _filenameController.text = document.fileName;
  }


  SingleChildScrollView _dataBody(BuildContext context){
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
                'DELETE',
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
                    onTap: (){
                      _showValues(document);
                      _selectedDocument = document;
                      setState(() {
                        _isUpdating = true;
                      });
                    }
                ),
                DataCell(
                    Container(
                        width: 100,
                        child: Text(
                          document.fileName.toUpperCase(),
                        )
                    ),
                    onTap: (){
                      _showValues(document);
                      _selectedDocument = document;
                      setState(() {
                        _isUpdating = true;
                      });
                    }
                ),
                DataCell(
                  Container(
                    //width: 75,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      onPressed: (){
                        showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button for close dialog!
                            builder: (BuildContext context){
                              return AlertDialog(
                                  title: Text('Delete Document?'),
                                  content: const Text(
                                      'This action is irreversible. Select Yes to confirm.'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: const Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        _deleteDocument(document);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ]
                              );
                            }
                        );
                      },
                    ),
                  ),
                ),
              ])
          ).toList(),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      userid = _auth.getUserID(user);
      getDisplayName(userid);
      getEmail(userid);
    }
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Course Documents'),
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
                        title: Text('Import Files Screen '),
                        content: const Text('This Screen is responsible for viewing documents. Select desired document for options.', style: TextStyle(fontSize: 20),),
                      );
                    }
                );
              }
          )
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: new Text("$_displayName", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              accountEmail:new Text("$_email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              currentAccountPicture: Icon(Icons.account_circle, size: 90),
              decoration: BoxDecoration(color: Colors.red[400]),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Import Students'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => importStudents()));
              },
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text('Courses'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CourseHome()));
              },
            ),
            ListTile(
              leading: Icon(Icons.file_upload),
              title: Text('Import Files'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => uploadFiles()));
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_turned_in),
              title: Text('Upload Grades'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => uploadGrades()));
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('View Documents'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewDocuments()));
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('View Students'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewStudents()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('List of documents for $coursecode'),
            _isUpdating
                ? Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _coursecodeController,
                      decoration: tenjinInputDecoration.copyWith(hintText: 'COURSE CODE EG. COMP2505'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _filenameController,
                      decoration: tenjinInputDecoration.copyWith(hintText: 'COMPUTER PROGRAMMING.PDF'),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.amber,
                    child: Text('Open Document'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => documentMaterial(coursecode: coursecode,Names:_filenameController.text,)));
                    },
                  ),
                  RaisedButton(
                    color: Colors.amber,
                    child: Text('UPDATE'),
                    onPressed: (){
                      return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Warning!!'),
                            content: const Text('Updating the details of a document may result in potential loss of data.'),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: const Text('UPDATE'),
                                onPressed: () {
                                  _updateDocument(_selectedDocument);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(width: 8.0,),
                  RaisedButton(
                    color: Colors.redAccent,
                    child: Text('CANCEL'),
                    onPressed: (){
                      setState(() {
                        _isUpdating = false;
                      });
                      _clearValues();
                    },
                  ),
                ],
              ),
            )
                : Container(),
            Expanded(
              child: _dataBody(context),
            )
          ],
        ),
      ),
    );
  }
}