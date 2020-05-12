import 'package:http/http.dart' as http;

class GradeServices {
  static const ROOT = 'http://10.0.2.2/tenjindb/uploadPoints.php';
  static const _UPLOAD_POINTS_ACTION = 'UPLOAD_POINTS';


  static Future uploadPoints(String email, String courseID, String creditPoint) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPLOAD_POINTS_ACTION;
      map['courseCode'] = courseID;
      map['email'] = email;
      map['creditPoint'] = creditPoint;

      final response = await http.post(ROOT, body: map);
      print('Upload credit points: ${response.body}');
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