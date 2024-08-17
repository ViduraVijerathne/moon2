import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/models/destination.dart';
import 'package:moon2/screens/home/home_screen.dart';
import 'package:moon2/screens/login/teacher_gether_bio_data.dart';
import 'package:moon2/services/course_service.dart';
import 'package:moon2/services/destination_service.dart';
import 'package:moon2/services/teacher_service.dart';
import 'package:provider/provider.dart';

import '../../models/teacher.dart';
import '../../services/auth_service.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  bool _isLoading = true;
  User? user;
  Teacher? teacher;
  Future<void> loadTeacher()async{
    user = Provider.of<AuthService>(context).currentUser;
    if(user != null){
      await Provider.of<TeacherService>(context,listen: false).loadCurrentTeacher(user!);
      teacher= Provider.of<TeacherService>(context,listen: false).getCurrentTeacher();
      if(teacher == null){
        print("Teacher not found ");
      }else{
        print("teacher is found");
      }
    }

  }

  Future<void> loadDestinations()async{
    await Provider.of<DestinationService>(context,listen: false).load();
  }

  Future<void> loadCourses()async{
    if(teacher == null){
      print("Teacher not Courses Are Not Loading ");
    }else{
      await Provider.of<CourseService>(context,listen: false).load(teacher!);
    }
  }

  void load()async{
    await loadTeacher();
    await loadDestinations();
    await loadCourses();
    setState(() {
      _isLoading = false;
    });
  }
  @override
  void didChangeDependencies() {
    load();

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return  _isLoading? Center(child: CupertinoActivityIndicator(),):
    Provider.of<TeacherService>(context,listen: false).getCurrentTeacher() == null ?
    TeacherGetherBioData(user:  Provider.of<AuthService>(context).currentUser!)  :
    HomeScreen();
  }
}
