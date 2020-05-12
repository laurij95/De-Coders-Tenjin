class Course{
  final String courseid;
  final String coursecode;
  final String coursename;
  final String userid;

  Course({this.courseid, this.coursecode, this.coursename, this.userid});

  factory Course.fromJson(Map<String, dynamic> json){
    return Course(
      courseid: json['courseid'] as String,
      coursecode: json['coursecode'] as String,
      coursename: json['coursename'] as String,
      userid: json['userid'] as String,
    );
  }
}