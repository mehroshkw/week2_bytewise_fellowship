
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week2/sharedpref/reusable_button.dart';
import 'package:week2/sharedpref/reusable_field.dart';

import 'auth_controller.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
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
                ReusablePrimaryButton(
                  onTap: () {
                    // authController.loginUser();
                    authController.sendpasswordresetemail(authController.emailController.text);
                  },
                  buttonText: 'Reset Password',
                ),
              ],
            ),
          )),
    );
  }
}