import 'package:flutter/material.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/business/p/MakePresenter.dart';
import 'package:fun_subway/business/view/MakeView.dart';

class MakePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MakeState();
  }
}

class MakeState extends BaseState<MakePresenter, MakePage> implements MakeView {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("make"),
    );
  }


  @override
  MakePresenter newInstance() {
    return MakePresenter();
  }
}