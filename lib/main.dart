import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week2/sharedpref/home.dart';
import 'package:week2/sharedpref/signup.dart';

import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var emails = prefs.getString("email");


  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: emails == null ? SignUpScreen() : HomePage(),
    // home: Contacts(),
  ));
}

