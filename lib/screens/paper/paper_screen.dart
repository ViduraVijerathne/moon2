import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/screens/paper/add_paper_screen.dart';

import '../../widget/my_app_bar.dart';
import '../course/add_course_screen.dart';

class PaperScreen extends StatelessWidget {
  const PaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: MyAppBar(title: "Your Papers",),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddPaperScreen(),));
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
