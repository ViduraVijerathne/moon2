import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:moon2/exceptions/data_store_exception.dart';
import 'package:moon2/models/subject.dart';

import '../models/teacher.dart';
import '../models/unit.dart';

class TeacherService with ChangeNotifier{
  Teacher? _currentTeacher;

  Future<void> addTeacher(Teacher teacher,List<Unit> units,Subject subject)async{
    // teachers/userID/bioData
    try{
      print("STEP 1");
      DocumentReference documentReference = FirebaseFirestore.instance.collection("teachers").doc(teacher.id).collection("bioData").doc();
      await documentReference.set(teacher.toJson());

      print("STEP 2");
      // teachers/userID/units
      for(Unit unit in units){
       DocumentReference ref =  FirebaseFirestore.instance.collection("teachers").doc(teacher.id).collection("units").doc();
       unit.id = ref.id;
       await ref.set(unit.toJson());
      }

      print("STEP 3");
      // subjectEnrolment/SubjectID/teachers
      DocumentReference ref = FirebaseFirestore.instance.collection("subjectEnrolment").doc(subject.id).collection("teachers").doc(teacher.id);
      await ref.set(teacher.toJson());

    }catch(e){
      throw DataStoreException(e.toString());
    }


  }

  Future<void> loadCurrentTeacher(User user)async{
    print("LOADING  CURRENT TEACHER START");
    print("LOADING  CURRENT TEACHER USER ID ${user.uid}");

    QuerySnapshot querySnapshot =await FirebaseFirestore.instance.collection("teachers").doc(user.uid).collection("bioData").get();
    print(_currentTeacher.toString());
    for(var doc in querySnapshot.docs){
      _currentTeacher = Teacher.fromJson(doc.data() as Map<String,dynamic>);
      print(_currentTeacher!.firstName);
      print("LOADING  CURRENT TEACHER PROCESSING");
      notifyListeners();
    }
    print("LOADING  CURRENT TEACHER END");


  }

  Teacher? getCurrentTeacher(){
    return _currentTeacher;
  }


}