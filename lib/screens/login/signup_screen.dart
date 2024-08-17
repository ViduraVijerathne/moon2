import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/constant/app_font.dart';
import 'package:moon2/exceptions/auth_exception.dart';
import 'package:moon2/screens/login/signin_screen.dart';
import 'package:moon2/screens/login/teacher_gether_bio_data.dart';
import 'package:moon2/services/auth_service.dart';
import 'package:moon2/widget/my_button.dart';
import 'package:moon2/widget/my_text_box.dart';
import 'package:provider/provider.dart';

import '../../widget/message_box.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isLoadinOnSubmit = false;
  void _onSubmit() async{
    setState(() {
      _isLoadinOnSubmit = true;
    });

    try{
      if(passwordController.text !=  confirmPasswordController.text){
        throw AuthException("password and confirm password should match");
      }
      await Provider.of<AuthService>(context,listen: false).signUpWithEmailAndPassword(emailController.text, passwordController.text);
      User? user = Provider.of<AuthService>(context,listen: false).currentUser;
      if(user != null){
        await showMessageBox(context, "Success", "Successfully Signup Add your bio data to Continue", MessageboxType.success);
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => TeacherGetherBioData(user: user),));
      }
    }on AuthException catch(e) {
      showMessageBox(context, "Signup Error", e.message, MessageboxType.error);
    }


    setState(() {
      _isLoadinOnSubmit = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Hero(
            tag: "LOGO",
            child: Center(
                child: SizedBox(
                    height:200,
                    width:200,
                    child: Image.asset("assets/logo.png",fit: BoxFit.fill,),
                ),
            ),
          ),

          const SizedBox(height: 20,),

          Text("Teachers Signup",style: appFont(fontSize: 35,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),

          const SizedBox(height: 20,),

          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextBox(text: "Email",controller: emailController,),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextBox(text: "Password",controller: passwordController,),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextBox(text: "Confirm Password",controller: confirmPasswordController,),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 75,
              child: MyButton(callback: _onSubmit,isLoading: _isLoadinOnSubmit ,title: "Signup"),
            ),
          ),

          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 75,
              child: GoogleButton(callback:() {
                Provider.of<AuthService>(context,listen: false).googleSignup();
              }, title: "Signup with Google"),
            ),
          ),

          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 75,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => SigninScreen(),));
                },
                child: Text("Already have a account? Login",style: appFont(fontSize: 25),),
              )
            ),
          ),
        ],
      ),
    );
  }
}
