import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/constant/app_colors.dart';
import 'package:moon2/constant/app_font.dart';
import 'package:moon2/exceptions/data_store_exception.dart';
import 'package:moon2/screens/wrappers/auth_wrapper.dart';
import 'package:moon2/services/subject_service.dart';
import 'package:moon2/services/teacher_service.dart';
import 'package:moon2/widget/message_box.dart';
import 'package:moon2/widget/my_button.dart';
import 'package:moon2/widget/my_text_box.dart';
import 'package:provider/provider.dart';

import '../../models/subject.dart';
import '../../models/teacher.dart';
import '../../models/unit.dart';

class TeacherGetherBioData extends StatelessWidget {
  final User user;
  const TeacherGetherBioData({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return _SelectSubjectScreen(user: user,);
  }
}

class _SelectSubjectScreen extends StatefulWidget {
  final User user;
  const _SelectSubjectScreen({super.key, required this.user,});

  @override
  State<_SelectSubjectScreen> createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<_SelectSubjectScreen> {
  List<Subject> subjects = [];
  Subject? selectedSubject;
  bool isLoading = true;

  void fetchSubjects()async{
    await Provider.of<SubjectService>(context,listen: false).loadSubjects();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    fetchSubjects();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Your Subject",style: appFont(fontWeight: FontWeight.w900,fontSize: 25 ),),
      ),
      body: isLoading? const Center(child: CupertinoActivityIndicator(color: Colors.black,),):
      Provider.of<SubjectService>(context).subjects.isEmpty ? Center(child: Text("No Subject Found",style: appFont(fontWeight: FontWeight.w900,fontSize: 30),),) :
      ListView.builder(
        itemCount: Provider.of<SubjectService>(context).subjects.length,
        itemBuilder: (context, index) {
          Subject subject = Provider.of<SubjectService>(context).subjects[index];
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:selectedSubject == subject? Colors.black: AppColors.gray,
              borderRadius: BorderRadius.circular(10),

            ),
            child: ListTile(
              onTap: () {
                setState(() {
                  selectedSubject = subject;
                });
              },
              title: Text(subject.subjectName,style: appFont(fontSize: 25,fontWeight: FontWeight.w700,color: selectedSubject == subject? Colors.white:null),),
            ),
          );
        },
      ),
      floatingActionButton: selectedSubject == null? null: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => _SubjectUnitsScreen(user:widget.user , subject: selectedSubject!),));
        },
        child: Icon(Icons.navigate_next,color: Colors.white,),
      ),
    );
  }
}

class _SubjectUnitsScreen extends StatefulWidget {
  final User user;
  final Subject subject;
  const _SubjectUnitsScreen({super.key, required this.user, required this.subject});

  @override
  State<_SubjectUnitsScreen> createState() => _SubjectUnitsScreenState();
}

class _SubjectUnitsScreenState extends State<_SubjectUnitsScreen> {
  final TextEditingController controller = TextEditingController();
  List<Unit> units = [];

  void add()async{
    for(Unit unit in units){
      if(unit.name == controller.text){
        await showMessageBox(context, "Oops!","that unit already exist", MessageboxType.info);
        return;
      }
    }
    Unit unit = Unit(id: "", name: controller.text);
    units.add(unit);
    setState(() {
      controller.clear();
      controller.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Units of Subject",style: appFont(fontWeight: FontWeight.w900,fontSize: 25 ),),
      ),
      body: Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          leadingWidth: 0,
          title: MyTextBox(text: "Unit Name",fontSize: 20,verticalPadding: 2,controller: controller,),
          actions: [
            FloatingActionButton(
              onPressed:add,
              child: const Icon(Icons.add,color: Colors.white,),
            )
          ],
        ),
        body: units.isEmpty ? Center(child: Text("Nothings to Show",style: appFont(fontWeight: FontWeight.w900),),):
        ListView.builder(
          itemCount: units.length,
          itemBuilder: (context, index) {
            Unit unit = units[index];
            GlobalKey key = GlobalKey();
            return Dismissible(
              key: key,
              onDismissed: (direction) {
                setState(() {
                  units.remove(unit);
                });
              },
              background: Container(
                decoration: BoxDecoration(
                  color:  Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              child:Container(
                margin:const EdgeInsets.all(5),
                padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(unit.name,style: appFont(fontWeight: FontWeight.w900,fontSize: 20),),
                  trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        units.remove(unit);
                      });
                    },
                    child: Icon(Icons.delete,color: Colors.red,),
                  ),
                ),
              ),

            );
          },
        ),
      ),
      floatingActionButton: units.isEmpty ? null:FloatingActionButton(
        onPressed: () {
          print("OK");
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => _AddBioDataScreen(user: widget.user, subject:widget.subject, units: units),));
        },
        child: Icon(Icons.navigate_next,color: Colors.white,),
      ),
    );
  }
}


class _AddBioDataScreen extends StatefulWidget {
  final User user;
  final Subject subject;
  final List<Unit> units;
  const _AddBioDataScreen({super.key, required this.user, required this.subject, required this.units});

  @override
  State<_AddBioDataScreen> createState() => _AddBioDataScreenState();
}

class _AddBioDataScreenState extends State<_AddBioDataScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController sloganController = TextEditingController();
  final TextEditingController educationStatusController = TextEditingController();
  bool isLoading =false;
  void finish()async{

    String profile = "https://i.ibb.co/4ZZKCHh/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail-removebg-pr.png";
    String cover = "https://images.pexels.com/photos/268941/pexels-photo-268941.jpeg?cs=srgb&dl=pexels-pixabay-268941.jpg&fm=jpg";
    if(firstNameController.text.isEmpty){
      showMessageBox(context, "Oops!","First Name is required", MessageboxType.info);
      return;
    }
    if(lastNameController.text.isEmpty){
      showMessageBox(context, "Oops!","Last Name is required", MessageboxType.info);
      return;
    }
    if(nicController.text.isEmpty){
      showMessageBox(context, "Oops!","NIC is required", MessageboxType.info);
      return;
    }
    if(contactController.text.isEmpty){
      showMessageBox(context, "Oops!","Contact is required", MessageboxType.info);
      return;
    }
    if(sloganController.text.isEmpty){
      showMessageBox(context, "Oops!","Slogan is required", MessageboxType.info);
      return;
    }
    if(educationStatusController.text.isEmpty){
      showMessageBox(context, "Oops!","Education Status is required", MessageboxType.info);
      return;
    }
    if(nicController.text.length < 10){
      showMessageBox(context, "Oops!","NIC should be 10 digit", MessageboxType.info);
      return;
    }
    if(contactController.text.length < 10){
      showMessageBox(context, "Oops!","Enter Correct Contact Number", MessageboxType.info);
      return;
    }

    Teacher teacher = Teacher(
      id: widget.user.uid,
      subjectName: widget.subject.subjectName,
      coverURL:profile,
      profileURL: cover,
      educationStatus: educationStatusController.text,
      email: widget.user.email!,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      nic: nicController.text,
      contact: contactController.text,
      slogan: sloganController.text,
      subjectID: widget.subject.id
    );
    setState(() {
      isLoading = true;
    });
    try{
      await Provider.of<TeacherService>(context,listen: false).addTeacher(teacher,widget.units,widget.subject);
      await showMessageBox(context, "Success!","Successfully Created Account", MessageboxType.success);
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => AuthWrapper(),));
    }on DataStoreException catch(e){
      showMessageBox(context, "Oops!",e.message, MessageboxType.error);
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Add Your Bio Data",style: appFont(fontWeight: FontWeight.w900,fontSize: 25 ),),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextBox(text: "First Name",controller: firstNameController,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextBox(text: "Last Name",controller: lastNameController,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextBox(text: "NIC",controller: nicController,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextBox(text: "Contact",controller: contactController,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextBox(text: "Slogan",controller: sloganController,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextBox(text: "Education Status",controller: educationStatusController,),
          ),
          const SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60,
              child: MyButton(
                title: "Finish",
                isLoading: isLoading,
                callback:finish,
              ),
            ),
          )
        ],
      ),
    );
  }
}



