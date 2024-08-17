import 'package:flutter/material.dart';
import 'package:moon2/models/course.dart';
import 'package:moon2/widget/my_app_bar.dart';

class SingleCourseView extends StatelessWidget {
  final Course course;
  const SingleCourseView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "${course.name} ${course.destination.name}"),
      body:Scaffold(
      ),
    );
  }
}
