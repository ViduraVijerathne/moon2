// teachers/userID/bioData
//subjectEnrolment/SubjectID/teachers
class Teacher{
  String id;
  String firstName;
  String lastName;
  String email;
  String slogan;
  String profileURL;
  String coverURL;
  String educationStatus;
  String subjectName;
  String subjectID;
  String nic;
  String contact;

  Teacher({required this.id,required this.firstName,required this.lastName, required this.email,required this.slogan,required this.profileURL,required this.coverURL,required this.educationStatus,required this.subjectName,required this.subjectID,required this.nic,required this.contact,});

   Map<String,dynamic> toJson(){
     return {
       'id': id,
       'firstName': firstName,
       'lastName': lastName,
       'email': email,
      'slogan': slogan,
       'profileURL': profileURL,
       'coverURL': coverURL,
       'educationStatus': educationStatus,
      'subjectName': subjectName,
      'subjectID': subjectID,
       'nic':nic,
       'contact': contact,
     };
  }

  static Teacher fromJson(Map<String,dynamic> data) {
     return Teacher(
       id: data['id'],
       firstName: data['firstName'],
       lastName: data['lastName'],
       email: data['email'],
       slogan: data['slogan'],
       profileURL: data['profileURL'],
       coverURL: data['coverURL'],
       educationStatus: data['educationStatus'],
       subjectName: data['subjectName'],
       subjectID: data['subjectID'],
       nic: data['nic'],
       contact: data['contact'],
     );
  }
}





class School{
  String id;
  String name;
  String district;

  School({required this.id, required this.name, required this.district});
}
class Students{
  String id;
  String firstName;
  String lastName;
  String email;
  String contact;
  String nic;
  School school;

  Students({required this.id,required this.firstName,required this.lastName,required this.email,required this.contact,required this.nic,required this.school});

}

