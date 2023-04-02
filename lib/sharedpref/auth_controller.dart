import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';

class AuthController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // final TextEditingController loginEmailController = TextEditingController();
  // final TextEditingController loginPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> createAccount() async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text).whenComplete(() => Get.to(LoginScreen()));
    final firestore = FirebaseFirestore.instance;
    firestore.collection('users').doc(user.user!.uid).set(
        {"email": emailController.text, "password": passwordController.text});
    if (user != null) {
      Get.to(LoginScreen());
    } else {
      print('error');
    }
  }

  Future<void> loginUser() async {
    final user = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text);
    if (user != null) {
      user.user!.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email",emailController.text );
      print(user.user!.uid);
      Get.to(HomePage());
    } else {
      print('error');
    }
  }


  Future<void> logoutUser() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginScreen());
  }



  Future<void> sendpasswordresetemail(String email) async{
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.offAll(LoginScreen());
      Get.snackbar("Password Reset email link is been sent", "Success");
    }).catchError((onError)=> Get.snackbar("Error In Email Reset", onError.message) );
  }

  //
  //   Future<OAuthCredential> signInWithGoogle() async {
  //   // FirebaseAuth.instance.signOut();
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn()
  //       .signIn()
  //       .whenComplete(() => Get.to(() => HomePage()));
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //
  //   // Create a new credential
  //   return GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  // }

//
// Future<UserCredential?> signInWithFacebook() async {
//   final LoginResult result = await FacebookAuth.instance.login();
//   if(result.status == LoginStatus.success){
//     // Create a credential from the access token
//     final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//   return null;
// }
}