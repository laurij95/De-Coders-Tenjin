
class Student{
  final String courseID;
  final String fname;
  final String lname;
  final String email;

  Student({this.courseID, this.fname, this.lname, this.email});

  factory Student.fromJson(Map<String, dynamic> json){
    return Student(
      courseID: json['courseID'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
    );
  }
}