import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'dart:ui';

import 'backdrop_img.dart';
import 'backdrop_imgntext.dart';
import 'get_img.dart';

class AddImg extends StatefulWidget {
  const AddImg({super.key});

  @override
  State<AddImg> createState() => _AddImgState();
}

class _AddImgState extends State<AddImg> {
  // to create imgurl collection in the firestore storage.
  CollectionReference? imgCollectionRef;
  firebase_storage.Reference? ref;
  @override
  void initState() {
    imgCollectionRef = FirebaseFirestore.instance.collection("imgUrl");
    super.initState();
  }

// Picking image start

  final ImagePicker _picker = ImagePicker();
  List<File>? imageList;
  pickMultiImages() async {
    List<XFile>? selectImg = await _picker.pickMultiImage();
    setState(() {
      // converting xfile into file.

      imageList = selectImg!.map<File>((xfile) => File(xfile.path)).toList();
      print("Image Picked ${imageList}");
      Fluttertoast.showToast(
          msg: "Image Selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
// Pick img end

// Storing img in fire-storage
  Future uploadImages() async {
    for (var img in imageList!) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("imgs/${Path.basename(img.path)}");
      await ref!.putFile(img).whenComplete(() async {
        await ref!.getDownloadURL().then((value) async {
          await imgCollectionRef!.add({"imgurl": value}).whenComplete(() {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return GetImages();
            }));
            Fluttertoast.showToast(
                msg: "Uploading Image. Please Wait.....",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Image to Firebase"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Images Upload to Firebase",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color.fromARGB(187, 175, 207, 235),
              ),
              margin: EdgeInsets.all(16.0),
              height: height / 2.5,
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: width / 2,
                    child: ElevatedButton(
                        onPressed: () {
                          pickMultiImages();
                        },
                        child: Text("Choose Images")),
                  ),
                  Container(
                    width: width / 2,
                    child: ElevatedButton(
                        onPressed: () {
                          uploadImages();
                        },
                        child: Text("Add Images")),
                  ),
                  Container(
                    width: width / 2,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return GetImages();
                          }));
                        },
                        child: Text("Go to Image Gallery")),
                  ),
                  Container(
                    width: width / 2,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ImageBlur()));
                        },
                        child: Text("Back-Drop Filter")),
                  ),
                  Container(
                    width: width / 2,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ImageTextBlur()));
                        },
                        child: Text("Back-Drop Filter with Text")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
