import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moon2/screens/wrappers/auth_wrapper.dart';
import 'package:moon2/services/auth_service.dart';
import 'package:moon2/services/course_service.dart';
import 'package:moon2/services/destination_service.dart';
import 'package:moon2/services/subject_service.dart';
import 'package:moon2/services/teacher_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/teacher.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => AuthService(),),
        ChangeNotifierProvider(create: (context) => TeacherService(),),
        ChangeNotifierProvider(create: (context) => SubjectService(),),
        ChangeNotifierProvider(create: (context) => DestinationService(),),
        ChangeNotifierProvider(create: (context) => CourseService(),),
      ],child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: Colors.black,
                onPrimary: Colors.black,
                secondary: Colors.grey,
                onSecondary: Colors.grey,
                error: Colors.red,
                onError: Colors.red,
                surface: Colors.white, onSurface: Colors.black)
        ),
        home: AuthWrapper(),
      ))
     ;
  }
}

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   bool isLoading = true;
//   List<Subject> subjects =[];
//   final TextEditingController controller = TextEditingController();
//
//   void load()async{
//     subjects.clear();
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("subjects").get();
//     for(QueryDocumentSnapshot doc in snapshot.docs){
//       Map<String,dynamic> map = doc.data() as Map<String,dynamic>;
//       subjects.add(Subject.fromJson(map));
//     }
//     if(mounted){
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void add()async{
//     setState(() {
//       isLoading = true;
//     });
//     DocumentReference reference =  FirebaseFirestore.instance.collection("subjects").doc();
//     Subject subject = Subject(id: reference.id,subjectName: controller.text);
//     reference.set(subject.toJson());
//    load();
//   }
//
//   @override
//   void initState() {
//     load();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: controller,
//         ),
//         leading: FilledButton(
//           child:Icon(Icons.add),
//           onPressed: add,
//         ),
//       ),
//
//       body: isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
//         itemCount: subjects.length,
//         itemBuilder: (context, index) {
//           Subject subject = subjects[index];
//
//           return ListTile(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeacherAddScreen(subject: subject),));
//             },
//             title: Text(subject.subjectName),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
// class TeacherAddScreen extends StatefulWidget {
//   final Subject subject;
//   const TeacherAddScreen({super.key,required this.subject});
//
//   @override
//   State<TeacherAddScreen> createState() => _TeacherAddScreenState();
// }
//
// class _TeacherAddScreenState extends State<TeacherAddScreen> {
//   final TextEditingController nameController = TextEditingController();
//   List<Teacher> teachers =[];
//   bool isLoading = false;
//
//   void add()async{
//     setState(() {
//       isLoading =true;
//     });
//     Teacher teacher = Teacher(id: "", firstName: nameController.text, lastName: nameController.text, email: nameController.text, slogan: "ammat siri", profileURL: "google.com", coverURL: "google.com", educationStatus: "BSC hons", subjectName: widget.subject.subjectName, subjectID: widget.subject.id);
//     DocumentReference reference = FirebaseFirestore.instance.collection("teachers").doc(nameController.text).collection("bioData").doc();
//     teacher.id = reference.id;
//     await reference.set(teacher.toJson());
//
//     CollectionReference teacherRef = FirebaseFirestore.instance.collection("subjectEnrolment").doc(widget.subject.id).collection("teachers");
//     await teacherRef.add(teacher.toJson());
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//   void load()async{
//     setState(() {
//       isLoading = true;
//     });
//     try{
//        QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("subjectEnrolment").doc(widget.subject.id).collection("teachers").get();
//        for(QueryDocumentSnapshot documentSnapshot in snapshot.docs){
//          Map<String,dynamic> map = documentSnapshot.data() as Map<String,dynamic>;
//          // print(map);
//          teachers.add(Teacher.fromJson(map));
//        }
//     }catch(e){
//       print(e);
//     }
//    setState(() {
//      print("LENGTH IS ${teachers.length}");
//      isLoading = false;
//    });
//   }
//
//
//   @override
//   void didChangeDependencies() {
//     load();
//     super.didChangeDependencies();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.add),
//           onPressed: add,
//         ),
//         title: TextField(
//           controller: nameController,
//         ),
//       ),
//       body:isLoading? Center(child: CircularProgressIndicator(),): teachers.length == 0 ? Center(child: Text("No data"),):  ListView.builder(
//         itemBuilder: (context, index) {
//           Teacher teacher = teachers[index];
//           return ListTile(
//             title: Text(teacher.firstName),
//           );
//         },
//         itemCount: teachers.length,
//       )
//     );
//   }
// }
