import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/shared/constants.dart';
import 'package:tenjin/teacher/models/documents.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/authenticate/sign_in.dart';
import 'package:tenjin/teacher/screens/documents/documentMaterial.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/documentServices.dart';

import '../../service/database.dart';

enum ConfirmAction { CANCEL, ACCEPT }

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
  }

  String _getDocuments(userid, coursecode){
    DocumentServices.getDocuments(userid, coursecode).then((documents){
      setState(() {
        _documents = documents;
      });
      print('Length ${documents.length}');
      //  Text("No Documents to show");
    });
  }

  _updateDocument(Document document){
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
  String _displayName = null;

  getDisplayName (String uid) async {
    await _db.getInfo(uid).then((val){
      setState(() {
        _displayName = val;
      });
    });
  }

  _deleteDocument(Document document){
    DocumentServices.deleteDocument(document.id).then((result){
      if('success' == result){
        _getDocuments(userid,coursecode);
      }
    });
  }

  _clearValues(){
    _coursecodeController.text = '';
    _filenameController.text = '';
  }

  _showValues(Document document){
    _coursecodeController.text = document.courseid;
    _filenameController.text = document.fileName;
  }


  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context,Document document) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: const Text(
              'Are you sure you want to delete this Course. It cannot be Undone!'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                //Navigator.of(context).pop(ConfirmAction.ACCEPT);
                _deleteDocument(document);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
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
          title: Text('Update!'),
          content: const Text('You are going to update'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                _updateDocument(_selectedDocument);
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
                        //_deleteDocument(document);  //put this in the confirmation!!!!!!!!!!!!!!!!!!!!!!11111
                        // calling the Alert function    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        _asyncConfirmDialog(context,document);
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
    }
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
              //await _auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh Contents',
            onPressed: (){
              print(coursecode);
              _getDocuments(userid,coursecode);
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('HELLO,$_displayName'),
            Text('List of documents for $coursecode'),
            Text(" "),
            Text("Click the document name to view or update the document."),
            Text(" "),
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
                      //_updateDocument(_selectedDocument);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => documentMaterial(coursecode: coursecode,Names:_filenameController.text,)));
                    },
                  ),
                  RaisedButton(
                    color: Colors.amber,
                    child: Text('UPDATE'),
                    onPressed: (){
                      //_updateDocument(_selectedDocument);
                      _ackAlert(context);
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
              child: _dataBody(),
            )
          ],
        ),
      ),
    );
  }
}