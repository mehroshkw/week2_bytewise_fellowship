import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'dart:io';

class ShareSaveImg extends StatefulWidget {
  String? image;
  ShareSaveImg({this.image});

  @override
  State<ShareSaveImg> createState() => _ShareSaveImgState();
}

class _ShareSaveImgState extends State<ShareSaveImg> {
  Future<void> shareImg() async {
    String url = widget.image.toString();
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    final imgpath = await File("${directory.path}/image$date.png").create();
    await imgpath.writeAsBytes(response.bodyBytes);
    Share.shareFiles([imgpath.path]);
  }

  saveImg() async {
    final savedirectory = await getTemporaryDirectory();
    String imgurl = widget.image.toString();
    final imgpath = "${savedirectory.path}/image.png";
    await Dio().downloadUri(Uri.parse(imgurl), imgpath);
    GallerySaver.saveImage(imgpath).whenComplete(() {
      print("Image Saved to Gallery");
      Fluttertoast.showToast(
          msg: "Image Saved To Gallery",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Share and Save Image"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: height,
          width: width,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.image.toString(),
                  width: 500,
                  height: 500,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    shareImg();
                  },
                  child: Text("Share Image")),
              ElevatedButton(
                  onPressed: () {
                    saveImg();
                  },
                  child: Text("Save To Gallery")),
            ],
          ),
        ),
      ),
    );
  }
}
