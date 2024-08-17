
import 'package:moon2/models/teacher.dart';
import 'package:moon2/models/unit.dart';

class Paper{
  String id;
  String title;
  String description;
  Teacher teacher;
  List<Question> questions;
  PaperMode mode;

  Paper({required this.id, required this.title,required this.description,required this.teacher,required this.questions,required this.mode});
}

class Question{
  String id;
  String questionText;
  List<String> images;
  List<Unit> units;
  List<Answer> answers;

  Question({required this.id, required this.questionText, required this.images, required this.units, required this.answers});
}

class Answer{
  String id;
  String answerText;
  String answerImage;
  bool isCorrect;
  Answer({required this.id, required this.answerText, required this.answerImage, required this.isCorrect});
}

enum PaperMode{
  COLAPSED,
  EXPANDED,
}