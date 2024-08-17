import 'package:moon2/models/destination.dart';

//
class Course{
  String id;
  String name;
  Destination destination;
  bool isPrivate;
  bool isActive;
  String teacherID;
  String teacherName;
  Course({required this.id, required this.name, required this.destination,required this.teacherName, required this.isPrivate,required this.isActive,required this.teacherID});

  Map<String,dynamic> toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "destination": this.destination.toJson(),
      "isPrivate": this.isPrivate,
      "isActive": this.isActive,
      "teacherID": this.teacherID,
      "teacherName": this.teacherName,
      "destinationID":destination.id,
    };
  }

  static Course fromJson(Map<String, dynamic> json){
    return Course(
      id: json["id"],
      name: json["name"],
      destination: Destination.fromJson(json["destination"]),
      teacherName: json["teacherName"],
      isPrivate: json["isPrivate"],
      isActive: json["isActive"],
      teacherID: json["teacherID"],
    );
  }
}