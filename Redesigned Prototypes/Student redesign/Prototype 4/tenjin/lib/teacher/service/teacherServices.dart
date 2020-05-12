import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tenjin/teacher/models/students.dart';

class TeacherServices{
  static const ROOT = 'http://10.0.2.2/tenjindb/teacherQueries.php';
  static const _GET_ALL_ACTION = 'GET_ALL';

  static List<Student> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Student>((json) => Student.fromJson(json)).toList();
  }

  static Future <List<Student>> getStudents(String coursecode) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['coursecode'] = coursecode;
      final response = await http.post(ROOT, body: map);
      if(200 == response.statusCode){
        List<Student> list = parseResponse(response.body);
        return list;
      }else{
        print(response.statusCode);
        return List<Student>();
      }
    }catch(e){
      print(e);
      return List<Student>();
    }
  }
}