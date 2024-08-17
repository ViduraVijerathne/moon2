import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moon2/screens/login/signin_screen.dart';
import 'package:moon2/screens/login/signup_screen.dart';
import 'package:moon2/screens/splash/splash_screen.dart';
import 'package:moon2/screens/wrappers/home_wrapper.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? SigninScreen() : HomeWrapper();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
