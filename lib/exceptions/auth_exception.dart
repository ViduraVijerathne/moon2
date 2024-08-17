import 'package:firebase_auth/firebase_auth.dart';

class AuthException  implements Exception {
  final String message;
  AuthException(this.message);
}