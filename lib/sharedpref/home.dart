import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week2/sharedpref/reusable_button.dart';
import '../firebase_crud/create.dart';
import '../firebase_crud/read.dart';
import '../images_mehrosh/add_img.dart';
import 'auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TextButton(
              child: Text("Create"),
              onPressed: () {
                Get.to(Create());
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: TextButton(
              child: Text("Read"),
              onPressed: () {
                Get.to(Read());
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: TextButton(
              child: Text("Add Image"),
              onPressed: () {
                Get.to(AddImg());
              },
            ),
          ),
          Center(
            child: ReusablePrimaryButton(
              buttonText: 'Logout',
              onTap: () {
                authController.logoutUser();
              },
            ),
          ),
        ],
      ),
    );
  }
}
