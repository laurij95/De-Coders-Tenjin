import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class UploadServices{
  static const ROOT = 'http://10.0.2.2/tenjindb/uploadFiles.php';
  static const _UPLOAD_FILE_ACTION = 'UPLOAD_FILE';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';

//  static Future <String> createTable() async {
//    try{
//      var map = Map<String,dynamic>();
//      map['action'] = _CREATE_TABLE_ACTION;
//      final response = await http.post(ROOT, body: map);
//      print('Create Table Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        print(response.statusCode);
//        return 'error';
//      }
//    }catch(e){
//      print(e);
//      return 'error';
//    }
//  }

  static Future uploadFile(String teacherID, String courseCode, String fileName,File file) async {

    StorageReference storageReference = FirebaseStorage.instance.ref().child('files_upload/${fileName}');
    StorageUploadTask uploadTask = storageReference.putFile(file);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    try{
      var map = Map<String,dynamic>();
      map['action'] = _UPLOAD_FILE_ACTION;
      map['teacherID'] = teacherID;
      map['courseCode'] = courseCode;
      map['fileName'] = fileName;
      map['fileUrl'] = url;




      final response = await http.post(ROOT, body: map);
      print('Upload File Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        print("error");
        print(response.statusCode);
        return 'error';
      }
    }catch(e){
      print(e);
      return 'error';
    }

  }






}
