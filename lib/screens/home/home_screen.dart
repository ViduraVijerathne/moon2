import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moon2/screens/course/course_screen.dart';
import 'package:moon2/screens/paper/paper_screen.dart';
import 'package:moon2/services/auth_service.dart';
import 'package:moon2/widget/my_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int activePage = 0;
   PageController pageController = PageController();

  void onChangeBottomNav(int index){
    setState(() {
      activePage = index;
    });

    pageController.animateToPage(
      activePage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> pages = [
    CourseScreen(),
    PaperScreen(),
    Center(child: Text("P3"),),
    Center(child: Text("P4"),),
  ];

  List<GButton> buttons = [
    getButton(icon: Icons.discount_rounded,name: "Courses"),
    getButton(icon: Icons.newspaper, name: "Papers"),
    getButton(icon: Icons.add_circle_outline, name: "Add"),
    getButton(icon: Icons.notifications_active, name: "Notifications"),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar:MyBottomNavBar(activePage: activePage,onChange:onChangeBottomNav,pageController: pageController,buttons: buttons,) ,
      );
  }
}
