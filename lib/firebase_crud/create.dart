import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:week2/firebase_crud/read.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> validate(String name, String email, String phone, String role,
        String address) async {
      if (formKey.currentState!.validate()) {
        await firestore.collection("data").add({
          "name": name,
          "email": email,
          "phone": phone,
          "role": role,
          "address": address,
        }).whenComplete(
          () => Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Read();
          })),
        );
        print("Success");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Add Your Infromation",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (v) {
                          if (nameController.text.isEmpty) {
                            return "Please Enter Your Name";
                          }
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (v) {
                          if (!emailController.text.contains("@gmail.com")) {
                            return "Please Enter Valid Email";
                          }
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (v) {
                          if (phoneController.text.length < 11) {
                            return "Phone Number Must Be 11 Digits";
                          }
                        },
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (v) {
                          if (roleController.text.isEmpty) {
                            return "Please Specify Buyer or Seller";
                          }
                        },
                        controller: roleController,
                        decoration: InputDecoration(
                          labelText: "User Role",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (v) {
                          if (addressController.text.isEmpty) {
                            return "Please Enter Your Address";
                          }
                        },
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: "Address",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  validate(
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      roleController.text,
                      addressController.text);
                },
                child: Text("Add Data"),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Read();
                    }));
                  },
                  child: Text("Skip to Home"))
            ],
          ),
        ),
      ),
    );
  }
}
