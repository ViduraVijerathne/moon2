import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon2/screens/login/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../constant/app_font.dart';
import '../../services/auth_service.dart';
import '../../widget/my_button.dart';
import '../../widget/my_text_box.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoadinOnSubmit = false;
  void _onSubmit() async{

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

          Text("Teachers SignIn",style: appFont(fontSize: 35,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),

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
              }, title: "SignIn with Google"),
            ),
          ),

          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
                height: 75,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => SignupScreen(),));
                  },
                  child: Text("Don't  have any  account? Login",style: appFont(fontSize: 25),),
                )
            ),
          ),
        ],
      ),
    );
  }
}
