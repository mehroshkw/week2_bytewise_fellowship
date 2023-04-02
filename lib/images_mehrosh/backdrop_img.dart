import 'dart:ui';
import 'package:flutter/material.dart';

class ImageBlur extends StatefulWidget {
  @override
  _ImageBlurState createState() => _ImageBlurState();
}

class _ImageBlurState extends State<ImageBlur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text("Flutter BackdropFilter Widget Demo"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            "https://media.istockphoto.com/photos/astronaut-conducting-spacewalk-on-earth-orbit-picture-id1166806194?k=20&m=1166806194&s=612x612&w=0&h=oDGk4uqIinEqhWJRaMzn6HZVLtlU88Tw3_di0gIW9EY=",
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 10.0,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
