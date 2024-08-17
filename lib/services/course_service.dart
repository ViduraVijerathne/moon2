import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:moon2/exceptions/data_store_exception.dart';

import '../models/course.dart';
import '../models/teacher.dart';

class CourseService with ChangeNotifier{
  List<Course> _courses = [];
  List<Course> get courses => _courses;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> load(Teacher teacher)async{
    print("loading Course Service Started");
    CollectionReference collectionReference = _firestore.collection("teachers").doc(teacher.id).collection("courses");
    QuerySnapshot snapshot = await collectionReference.get();
    for(QueryDocumentSnapshot queryDocumentSnapshot in snapshot.docs){
     Map<String,dynamic> map =  queryDocumentSnapshot.data() as Map<String,dynamic> ;
     Course course = Course.fromJson(map);
     _courses.add(course);
    }
    print("loading Course Service Ended with ${_courses.length} courses");
    notifyListeners();
  }

  Future<void> addCourse(Course course,Teacher teacher)async{
    DocumentReference documentReference = _firestore.collection("teachers").doc(teacher.id).collection("courses").doc();
    try{
      course.id = documentReference.id;
      await documentReference.set(course.toJson());
      _courses.add(course);
      notifyListeners();

    }catch(e){
      throw DataStoreException("Something went wrong");
    }


  }
}