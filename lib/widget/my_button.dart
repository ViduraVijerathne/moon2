import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/constant/app_font.dart';

class MyButton extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final bool isLoading;
  const MyButton({super.key, required this.callback, required this.title,  this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed:callback ,
        style:FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Change this value to adjust the radius
          ),
        ),
        child: isLoading? CupertinoActivityIndicator(color: Colors.white,): Text(
          title,
          style: appFont(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
          ),));
  }
}


class GoogleButton extends StatelessWidget {
  final VoidCallback callback;
  final String title;

  const GoogleButton({super.key, required this.callback, required this.title});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed:callback ,
        style:FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Change this value to adjust the radius
          ),
        ),
        child: Row(
          children: [
            Image.asset("assets/google.png",fit: BoxFit.fill,),
            const SizedBox(width: 10,),
            Text(
              title,
              style: appFont(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),),
          ],
        ));
  }
}

