import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final Function(int) onChange;
  final List<GButton> buttons;
  final int activePage;
  final PageController pageController;

  const MyBottomNavBar({super.key, required this.onChange, required this.buttons, required this.activePage, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return  GNav(
        onTabChange: onChange,
        color: Colors.black,
        activeColor: Colors.white,
        // backgroundColor: Colors.red.withOpacity(0.1),
        hoverColor: Colors.black,
        tabs:buttons
    );
  }
}

GButton getButton({required String name,required  IconData icon}){
  return GButton(
    icon: icon,
    text: name,
    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
    margin: EdgeInsets.symmetric(vertical:10),
    backgroundColor: Colors.black,
  );
}

