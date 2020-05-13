import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tenjin/teacher/models/documents.dart';

class DocumentServices{
  static const ROOT = 'http://10.0.2.2/tenjindb/documentQueries.php';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _UPDATE_DOCUMENT_ACTION = 'UPDATE_DOCUMENT';
  static const _DELETE_DOCUMENT_ACTION = 'DELETE_DOCUMENT';




  static List<Document> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Document>((json) => Document.fromJson(json)).toList();
  }

  static Future <List<Document>> getDocuments(String userid, String coursecode) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_ALL_ACTION;
      map['userid'] = userid;
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

  static Future <String> updateDocument(String id, String coursecode, String filename) async {
    try {
      var map = Map <String, dynamic>();
      map['action'] = _UPDATE_DOCUMENT_ACTION;
      map['id'] = id;
      map['coursecode'] = coursecode;
      map['filename'] = filename;
      final response = await http.post(ROOT, body: map);
      print('Update Document Response: ${response.body}');
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

  static Future <String> deleteDocument(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_DOCUMENT_ACTION;
      map['id'] = id;
      final response = await http.post(ROOT, body: map);
      print('Delete Document Response: ${response.body}');
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