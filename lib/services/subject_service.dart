import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/subject.dart';

class SubjectService with ChangeNotifier{
  List<Subject> _subjects = [];
  CollectionReference subjectReference = FirebaseFirestore.instance.collection("subjects");

  Future<void> loadSubjects()async{
    QuerySnapshot snapshot = await subjectReference.get();
    for(QueryDocumentSnapshot documentSnapshot in snapshot.docs){
      Map<String,dynamic> map = documentSnapshot.data() as Map<String,dynamic>;
      Subject subject = Subject.fromJson(map);
      _subjects.add(subject);
    }
    notifyListeners();
  }

  List<Subject> get subjects => _subjects;
}