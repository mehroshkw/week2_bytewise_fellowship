import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week2/sharedpref/reusable_button.dart';
import 'package:week2/sharedpref/reusable_field.dart';
import 'package:week2/sharedpref/signup.dart';
import 'auth_controller.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ReusableTextField(
              labelText: 'Phone/Email',
              controller: authController.emailController,
            ),
            SizedBox(
              height: 20,
            ),
            ReusableTextField(
              labelText: 'Password',
              controller: authController.passwordController,
            ),
            SizedBox(
              height: 20,
            ),

            // custom button and converting into  component
            ReusablePrimaryButton(
              onTap: () {
                authController.loginUser();
              },
              buttonText: 'Login',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have any account?'),
                TextButton(
                  onPressed: () {
                    Get.to(SignUpScreen());
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forgot Password?'),
                TextButton(
                  onPressed: () {
                    Get.to(ForgotPass());
                  },
                  child: Text('Reset Password'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
