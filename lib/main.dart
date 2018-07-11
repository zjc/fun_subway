import 'package:flutter/material.dart';
import 'package:fun_subway/pages/splash.dart';
import 'pages/NewMain.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter app',
      home: new Splash(),
      routes: {
        '/MainPage': (BuildContext context) => new MainPage(),
      },
    );
  }
}
