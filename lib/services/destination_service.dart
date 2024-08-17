import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:moon2/models/course.dart';
import 'package:moon2/models/destination.dart';

import '../models/teacher.dart';

class DestinationService with ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Destination> _destinations = [];
  List<Destination> get destination => _destinations;


  Future<void> load()async{
    _destinations.clear();
    print("Loadin Destinations");
    QuerySnapshot snapshot = await _firestore.collection("destinations").get();
    snapshot.docs.forEach((doc) => _destinations.add(Destination.fromJson(doc.data() as Map<String, dynamic>)));
    print("Loading Destinations End with ${_destinations.length} ");
    notifyListeners();
  }

  Future<void> addDestination(String name)async{
    DocumentReference documentReference = _firestore.collection("destinations").doc();
    Destination destination = Destination(id: documentReference.id, name: name);
    await documentReference.set(destination.toJson());
    notifyListeners();
  }


}