import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/constant/app_colors.dart';
import 'package:moon2/constant/app_font.dart';
import 'package:moon2/screens/course/add_course_screen.dart';
import 'package:moon2/screens/course/single_course_view.dart';
import 'package:moon2/services/course_service.dart';
import 'package:moon2/services/destination_service.dart';
import 'package:moon2/widget/my_app_bar.dart';
import 'package:provider/provider.dart';

import '../../models/course.dart';


class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Your Courses",),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddCourseScreen(),));
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: ListView.builder(
        itemCount: Provider.of<CourseService>(context).courses.length,
        itemBuilder: (context, index) {
          Course course = Provider.of<CourseService>(context).courses[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.gray,
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => SingleCourseView(course: course),));
              },
              title: Text(course.name,style: appFont(fontWeight: FontWeight.w900,fontSize: 25),),
              subtitle: Text(course.destination.name,style: appFont(fontSize: 20,fontWeight: FontWeight.w800),),
            ),
          );
        },

      ),
    );
  }
}
