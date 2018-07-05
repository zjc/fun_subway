import 'package:flutter/material.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/p/MyPresenter.dart';
import 'package:fun_subway/view/MyView.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends BaseState<MyPresenter, MyPage> implements MyView {
  @override
  Widget build(BuildContext context) {

    return new Center(
      child: new Text("my"),
    );
  }


  @override
  MyPresenter newInstance() {
    return MyPresenter();
  }
}