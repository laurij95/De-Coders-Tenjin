class Document{
  final String id;
  final String teacherid;
  final String courseid;
  final String fileName;
  final String fileUrl;

  Document({this.id, this.teacherid, this.courseid, this.fileName, this.fileUrl});

  factory Document.fromJson(Map<String,dynamic> json){
    return Document(
      id: json['id'] as String,
      teacherid: json['teacher_id'] as String,
      courseid: json['course_id'] as String,
      fileName: json['file_name'] as String,
      fileUrl: json['file_url'] as String,
    );
  }

}