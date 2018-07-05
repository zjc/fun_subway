import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_subway/view/SplashView.dart';
import 'package:fun_subway/p/SplashPresenter.dart';
import 'package:fun_subway/framework/BaseState.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends BaseState<SplashPresenter, Splash>
    implements SplashView {
  @override
  Widget build(BuildContext context) {
    return new Image.asset('images/ic_splash.gif');
  }

  @override
  void initState() {
    super.initState();
    mPresenter.fetchConfig();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void fetchConfigSuccess() {
    countDown();
  }

  void countDown() {
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, go2MainPage);
  }

  void go2MainPage() {
    Navigator.of(context).pushReplacementNamed('/MainPage');
  }

  @override
  SplashPresenter newInstance() {
    return new SplashPresenter();
  }
}
