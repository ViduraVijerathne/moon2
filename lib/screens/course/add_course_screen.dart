import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/constant/app_colors.dart';
import 'package:moon2/constant/app_font.dart';
import 'package:moon2/exceptions/data_store_exception.dart';
import 'package:moon2/models/course.dart';
import 'package:moon2/screens/home/home_screen.dart';
import 'package:moon2/services/course_service.dart';
import 'package:moon2/services/destination_service.dart';
import 'package:moon2/services/teacher_service.dart';
import 'package:moon2/widget/message_box.dart';
import 'package:moon2/widget/my_app_bar.dart';
import 'package:moon2/widget/my_button.dart';
import 'package:moon2/widget/my_text_box.dart';
import 'package:provider/provider.dart';

import '../../models/destination.dart';
import '../../models/teacher.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add New Course"),
      body: _AddCourseSelectDestinationScreen(),

    );
  }
}


class _AddCourseSelectDestinationScreen extends StatefulWidget {
  const _AddCourseSelectDestinationScreen({super.key,});

  @override
  State<_AddCourseSelectDestinationScreen> createState() => _AddCourseSelectDestinationScreenState();
}

class _AddCourseSelectDestinationScreenState extends State<_AddCourseSelectDestinationScreen> {
  List<Destination> destinations = [];
  bool _isLoading = true;
  Destination? selected;

  Future<void> getDestinations()async{
    destinations = Provider.of<DestinationService>(context).destination;
    if(destinations.isEmpty){
      await Provider.of<DestinationService>(context,listen: false).load();
      destinations = Provider.of<DestinationService>(context).destination;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void load()async{
    await getDestinations();
  }
  @override
  void didChangeDependencies() {
    load();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "First Select A  Destination",showLeading: false,isH1: false,isCenterTitle: true),
      body: _isLoading ? Center(child: CupertinoActivityIndicator(),):
      ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          Destination destination = destinations[index];
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selected == null ? AppColors.gray : selected == destination ? Colors.black : AppColors.gray,
            ),
            child: ListTile(
              onTap: () {
                setState(() {
                  selected = destination;
                });
              },
              title: Text(destination.name,style: appFont(fontSize: 18,fontWeight: FontWeight.w600,color: selected == null ? null : selected == destination? Colors.white : null ),),

            ),
          );
        },
      ),
      floatingActionButton: selected == null ? null : FloatingActionButton(
        onPressed: ()async {
         await Navigator.of(context).push(CupertinoPageRoute(builder: (context) => _AddCourseSelectNameScreen(destination: selected!),));
         setState(() {

         });
         },
        child: Icon(Icons.navigate_next,color: Colors.white,),
      ),

    );
  }
}


class _AddCourseSelectNameScreen extends StatefulWidget {
  final Destination destination;
  const _AddCourseSelectNameScreen({super.key, required this.destination});

  @override
  State<_AddCourseSelectNameScreen> createState() => _AddCourseSelectNameScreenState();
}

class _AddCourseSelectNameScreenState extends State<_AddCourseSelectNameScreen> {
  bool isPrivate = false;
  bool _isLoading = false;
  final TextEditingController _controller = TextEditingController();

  void submit()async{

    if(_controller.text.isEmpty){
      await showMessageBox(context, "Oops!","Please Enter Course Name", MessageboxType.error);
      return;
    }
    Teacher  teacher = Provider.of<TeacherService>(context,listen: false).getCurrentTeacher()!;
    Course course = Course(id: "", name: _controller.text, teacherName:"${teacher.firstName} ${teacher.lastName}",destination: widget.destination,teacherID: teacher.id, isPrivate: isPrivate, isActive: true);
    try{
      setState(() {
        _isLoading = true;
      });
     await Provider.of<CourseService>(context,listen: false).addCourse(course,teacher);
     await showMessageBox(context,"Success!","Course Added Successfully", MessageboxType.success);
     Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => HomeScreen(),));
    }on DataStoreException catch(ex){
      await showMessageBox(context,"Oops!",ex.message, MessageboxType.error);
    }
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add New Course"),
      body: Scaffold(
        appBar: MyAppBar(title: "Now Add A Course Name And Set Privacy",showLeading: false,isH1: false,isCenterTitle: true),
        body: ListView(
          children: [
            const SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20),
                child: Text(widget.destination.name,style: appFont(fontSize: 20,fontWeight: FontWeight.w900),)),
            const SizedBox(height: 20,),
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextBox(text: "Course Name",controller: _controller,),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPrivate = !isPrivate;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isPrivate? Colors.black : AppColors.gray,
                      ),
                      child: Center(
                        child: Text("Private",style: appFont(fontWeight: FontWeight.w900,fontSize: 20,color: isPrivate ? Colors.white : null),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPrivate = !isPrivate;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isPrivate?  AppColors.gray :Colors.black,
                      ),
                      child: Center(
                        child: Text("Public",style: appFont(fontWeight: FontWeight.w900,fontSize: 20,color: isPrivate ? null: Colors.white),),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 70,
                child: MyButton(callback:submit, title: "Add",isLoading: _isLoading),
              ),
            )
          ],
        ),
      ),
    );
  }
}
