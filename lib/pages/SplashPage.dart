import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_subway/business/view/SplashView.dart';
import 'package:fun_subway/business/p/SplashPresenter.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends BaseState<SplashPresenter, SplashPage>
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
    FunRouteFactory.go2MainPage(context);
  }

  @override
  SplashPresenter newInstance() {
    return new SplashPresenter();
  }
}
