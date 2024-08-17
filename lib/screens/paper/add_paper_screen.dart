import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/constant/app_font.dart';
import 'package:moon2/models/paper.dart';
import 'package:moon2/models/teacher.dart';
import 'package:moon2/services/teacher_service.dart';
import 'package:moon2/widget/message_box.dart';
import 'package:moon2/widget/my_button.dart';
import 'package:moon2/widget/my_text_box.dart';
import 'package:provider/provider.dart';

import '../../widget/my_app_bar.dart';

class AddPaperScreen extends StatefulWidget {

  const AddPaperScreen({super.key});

  @override
  State<AddPaperScreen> createState() => _AddPaperScreenState();
}

class _AddPaperScreenState extends State<AddPaperScreen> {
  final TextEditingController _paperNameController = TextEditingController();
  final TextEditingController _paperDescriptionController = TextEditingController();
  PaperMode _paperMode = PaperMode.COLAPSED;

  void submit(){
    if(_paperNameController.text.isEmpty){
      showMessageBox(context,"Oops!","Please Add a Paper title", MessageboxType.error);
      return;
    }
    if(_paperDescriptionController.text.isEmpty){
      showMessageBox(context,"Oops!","Please Add a Paper Description", MessageboxType.error);
      return;
    }
    Teacher teacher = Provider.of<TeacherService>(context,listen: false).getCurrentTeacher()!;
    // Paper paper = Paper(id: "", title: _paperNameController.text, description: _paperDescriptionController.text, teacher: teacher, questions: []);
    // Navigator.of(context).push(CupertinoPageRoute(builder: (context) => _QuestionScreen(paper:paper),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add New Course"),
      body: Scaffold(
        appBar: MyAppBar(title: "Now Add A Paper Details",showLeading: false,isH1: false,isCenterTitle: true),
        body: ListView(
          children: [
            const SizedBox(height: 50,),
            Container(
              margin:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child:  MyTextBox(text: "Paper Title",controller: _paperNameController,),
            ),
            Container(
              margin:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child:  MyTextBox(text: "Paper Description",controller:_paperDescriptionController ,),
            ),
            const SizedBox(height: 20,),
           ToggleButtons(children: [
             Text("Expanded"),
             Text("Collapsed"),
           ], isSelected: [true, false])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: submit,
        child: Icon(Icons.navigate_next,color: Colors.white,),
      ),
    );
  }
}

class _QuestionScreen extends StatefulWidget {
  final Paper paper;
  const _QuestionScreen({super.key, required this.paper});

  @override
  State<_QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<_QuestionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add New Course"),
      body: Scaffold(

        appBar: MyAppBar(title: "Now Add A Paper Question",showLeading: false,isH1: false,isCenterTitle: true),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: const Icon(Icons.add,color: Colors.white,),
        ),
      ),
    );
  }
}


