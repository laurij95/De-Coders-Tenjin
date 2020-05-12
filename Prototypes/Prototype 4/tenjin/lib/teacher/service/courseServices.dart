import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tenjin/teacher/models/courses.dart';

class CourseServices {
  static const ROOT = 'http://10.0.2.2/tenjindb/courseQueries.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  //static const _CHECK_FOR_DUPLICATES = 'CHECK_FOR_DUPLICATES';
  static const _ADD_COURSE_ACTION = 'ADD_COURSE';
  static const _UPDATE_COURSE_ACTION = 'UPDATE_COURSE';
  static const _DELETE_COURSE_ACTION = 'DELETE_COURSE';

  static List<Course> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Course>((json) => Course.fromJson(json)).toList();
  }

  static Future <String> createTable() async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        print(response.statusCode);
        return 'error';
      }
    }catch(e){
      print(e);
      return 'error';
    }
  }

  static Future <List<Course>> getCourses(String userid) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['userid'] = userid;
      final response = await http.post(ROOT, body: map);
      if(200 == response.statusCode){
        List<Course> list = parseResponse(response.body);
        return list;
      }else{
        print(response.statusCode);
        return List<Course>();
      }
    }catch(e){
      print(e);
      return List<Course>();
    }
  }

  // static Future <String> checkForDuplicates(String coursecode, String coursename) async{
  //   try{
  //     var map = Map<String, dynamic>();
  //     map['action'] = _CHECK_FOR_DUPLICATES;
  //     map['coursecode'] = coursecode;
  //     map['coursename'] = coursename;
  //     final response = await http.post(ROOT, body: map);
  //     print('You are trying to add a record...Checking For Duplicates...~ Response: ${response.body}');
  //     if(200 == response.statusCode){
  //       return response.body;
  //     }else{
  //       print(response.statusCode);
  //       return 'error';
  //     }
  //   }catch(e){
  //     print(e);
  //     return 'error';
  //   }
  // }

  static Future <String> addCourse(String coursecode, String coursename, String userid) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _ADD_COURSE_ACTION;
      map['coursecode'] = coursecode;
      map['coursename'] = coursename;
      map['userid'] = userid;

      final response = await http.post(ROOT, body: map);
      print('Add Course Response: ${response.body}');
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

  static Future <String> updateCourse(String courseid, String coursecode, String coursename) async {
    try {
      var map = Map <String, dynamic>();
      map['action'] = _UPDATE_COURSE_ACTION;
      map['courseid'] = courseid;
      map['coursecode'] = coursecode;
      map['coursename'] = coursename;
      final response = await http.post(ROOT, body: map);
      print('Update Course Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }

  static Future <String> deleteCourse(String courseid) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_COURSE_ACTION;
      map['courseid'] = courseid;
      final response = await http.post(ROOT, body: map);
      print('Delete Course Response: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }

}