import 'package:flutter/material.dart';
import 'package:fun_subway/business/FunAuth.dart';
import 'package:fun_subway/pages/SplashPage.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'pages/MainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FunAuth funAuth = new FunAuth();
    funAuth.doAuthVerify();

    return new MaterialApp(
      title: 'Flutter app',
      home: new SplashPage(),
      theme: new ThemeData(
          primaryColor: FunColors.themeColor,
          accentColor: FunColors.themeColor,
          bottomAppBarColor:Colors.white,
          inputDecorationTheme: new InputDecorationTheme(
            border: new UnderlineInputBorder(
                borderSide: new BorderSide(color: FunColors.c_666,width: 0.5)),
          ),
          hintColor: FunColors.c_999,
      ),
      routes: {
        '/MainPage': (BuildContext context) => new MainPage(),
      },
    );
  }
}
