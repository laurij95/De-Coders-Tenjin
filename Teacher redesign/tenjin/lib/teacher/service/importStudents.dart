import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tenjin/teacher/models/students.dart';


class ImportStudents {
  static const ROOT = 'http://10.0.2.2/tenjindb/addStudents.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _ADD_STUDENT = 'ADD_STUDENT';


//  static Future <String> createTable() async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _CREATE_TABLE_ACTION;
//      final response = await http.post(ROOT, body: map);
//      print('Create Table Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        print(response.statusCode);
//        return 'error';
//      }
//    } catch (e) {
//      print(e);
//      return 'error';
//    }
//  }

  static Future <String> addStudent(String courseID, String fname, String lname, String email) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _ADD_STUDENT;
      map['courseID'] = courseID;
      map['fname'] = fname;
      map['lname'] = lname;
      map['email'] = email;

      final response = await http.post(ROOT, body: map);
      print('Add Student Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        print(response.statusCode);
        return "error";
      }
    }catch(e){
      print(e);
      return "error";
    }
  }

}