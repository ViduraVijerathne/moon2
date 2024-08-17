//subjects/
class Subject{
  String id;
  String subjectName;
  Subject({required this.id, required this.subjectName});

  static Subject fromJson(Map<String,dynamic> data) {
    return Subject(
      id: data['id'],
      subjectName: data['subjectName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectName': subjectName,
    };
  }
}