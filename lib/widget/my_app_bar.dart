import 'package:flutter/material.dart';
import 'package:moon2/constant/app_font.dart';

AppBar MyAppBar({required String title,  bool showLeading = true,bool isH1 = true,bool isCenterTitle = false}){
  return AppBar(
    title: Text(title,style: isH1 ?  appFont(fontWeight: FontWeight.w900,fontSize: 25):
    appFont(fontWeight: FontWeight.w600,fontSize: 25),),
    leadingWidth: showLeading ? null : 0,
    leading: showLeading? null:const SizedBox(),
    centerTitle: isCenterTitle,
  );
}