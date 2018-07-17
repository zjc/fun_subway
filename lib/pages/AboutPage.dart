import 'package:flutter/material.dart';
import 'package:fun_subway/utils/FunColors.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "关于",
          style: new TextStyle(color: FunColors.c_333, fontSize: 18.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black87),
      ),
      body: new Text("关于内容"),
    );
  }
}
