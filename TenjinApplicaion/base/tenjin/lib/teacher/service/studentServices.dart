import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tenjin/teacher/models/documents.dart';

class StudentServices{
  static const ROOT = 'http://10.0.2.2/tenjindb/studentQueries.php';
  static const _GET_ALL_ACTION = 'GET_ALL';

  static List<Document> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Document>((json) => Document.fromJson(json)).toList();
  }

  static Future <List<Document>> getDocuments(String coursecode) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['coursecode'] = coursecode;
      final response = await http.post(ROOT, body: map);
      if(200 == response.statusCode){
        List<Document> list = parseResponse(response.body);
        return list;
      }else{
        print(response.statusCode);
        return List<Document>();
      }
    }catch(e){
      print(e);
      return List<Document>();
    }
  }
}