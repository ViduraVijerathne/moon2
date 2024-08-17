import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moon2/exceptions/auth_exception.dart';
import 'package:provider/provider.dart';

class AuthService with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password)  async {
    if(email.isEmpty){
      throw AuthException("Email field cannot be empty.");
    }
    if(password.isEmpty){
      throw AuthException("Password field cannot be empty.");
    }
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      print(e.code);
      print(e.message);
      switch (e.code) {
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'user-disabled':
          errorMessage = "This user account has been disabled.";
          break;
        case 'user-not-found':
          errorMessage = "No user found for this email.";
          break;
        case 'wrong-password':
          errorMessage = "Wrong password provided.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Try again later.";
          break;
        case 'operation-not-allowed':
          errorMessage = "Email and password sign-in is not enabled.";
          break;
        case 'email-already-in-us':
          errorMessage = "The email address is already in use by another account.";
          break;
        case 'weak-password':
          errorMessage = "The password is too weak. minimum 6 characters";
          break;
        case 'user-token-expired':
          errorMessage = "The user's credential is expired. The user must sign in again.";
          break;
        case 'network-request-failed':
          errorMessage = "Network request failed. Please check your internet connection.";
          break;
        case 'email-already-in-use':
          errorMessage = "The email address is already in use by another account.";
          break;
        default:
          errorMessage = "An undefined error occurred.";
      }
      throw AuthException(errorMessage);
    } catch (e) {
      throw AuthException("An unexpected error occurred. Please try again later");
    }
  }

  Future<void> googleSignup()async{
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        throw AuthException("Google sign-in was canceled.");
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      await _auth.signInWithCredential(credential);
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> logout()async{
    await  _auth.signOut();
    await GoogleSignIn().signOut();

  }

}