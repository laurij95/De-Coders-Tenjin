import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenjin/teacher/models/user.dart';
import 'package:tenjin/teacher/screens/documents/viewDocuments.dart';
import 'package:tenjin/teacher/screens/files/import_students.dart';
import 'package:tenjin/teacher/screens/files/upload_file.dart';
import 'package:tenjin/teacher/screens/files/upload_grade.dart';
import 'package:tenjin/teacher/screens/home/teachcourses.dart';
import 'package:tenjin/teacher/screens/student/ViewStudents.dart';
import 'package:tenjin/teacher/service/auth.dart';
import 'package:tenjin/teacher/service/database.dart';
import '../wrapper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  String _displayName, _email = null;
  String userid;

  @override
  void initState(){
    userid;
  }

  //the getDisplayName(String uid) and getEmail (String uid) return the credentials of the authenticated user that is saved in Firestore
  getDisplayName (String uid) async {
      await _db.getInfo(uid).then((val){
        if(mounted) {
          setState(() {
            _displayName = val;
          });
        }
      });
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(mounted){
      if (user != null) {
        userid = _auth.getUserID(user);
        getDisplayName(userid);
        getEmail(userid);
      }
    }
      return Scaffold(
          backgroundColor: Colors.red[50],
          appBar: AppBar(
            title: Text('Home'),
            backgroundColor: Colors.red[400],
            elevation: 0.0,
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
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Wrapper()));
                  },
                )
              ],
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(30),
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => importStudents()),
                      );
                    },
                    splashColor: Colors.redAccent[100],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.contacts, size: 70),
                          Text("Import Students",
                            style: new TextStyle(fontSize: 17),)
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CourseHome()),
                      );
                    },
                    splashColor: Colors.redAccent[100],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.class_, size: 70),
                          Text("Courses", style: new TextStyle(fontSize: 17),)
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => uploadFiles()),
                      );
                    },
                    splashColor: Colors.redAccent[100],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.file_upload, size: 70),
                          Text(
                            "Import Files", style: new TextStyle(fontSize: 17),)
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => uploadGrades()),
                      );
                    },
                    splashColor: Colors.redAccent[100],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.assignment_turned_in, size: 70),
                          Text("Upload Grades",
                            style: new TextStyle(fontSize: 17),)
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewDocuments()),
                      );
                    },
                    splashColor: Colors.redAccent[100],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.library_books, size: 70),
                          Text("View Documents",
                            style: new TextStyle(fontSize: 17),)
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewStudents()),
                      );
                    },
                    splashColor: Colors.redAccent[100],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.supervised_user_circle, size: 70),
                          Text("View Students",
                            style: new TextStyle(fontSize: 17),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }
}
