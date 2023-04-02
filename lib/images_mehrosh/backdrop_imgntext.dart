import 'dart:ui';

import 'package:flutter/material.dart';

class ImageTextBlur extends StatefulWidget {
  @override
  _ImageTextBlurState createState() => _ImageTextBlurState();
}

class _ImageTextBlurState extends State<ImageTextBlur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text("Flutter BackdropFilter Widget Demo"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            "https://st4.depositphotos.com/15964096/20036/i/450/depositphotos_200367782-free-stock-photo-young-beautiful-woman-posing-beach.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 6.0,
                  sigmaY: 6.0,
                ),
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(8.0),
                  color: Colors.white.withOpacity(0.5),
                  child: Text(
                    "“Every sunset is an opportunity to reset.” \n – Richie Norton ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
