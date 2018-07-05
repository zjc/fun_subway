import 'package:flutter/material.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/p/HomePresenter.dart';
import 'package:fun_subway/view/HomeView.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends BaseState<HomePresenter, HomePage> implements HomeView {
  @override
  Widget build(BuildContext context) {
    Widget searchWidget = buildSearchWidget();
    return new Center(
      child: new Text("Home"),
    );
  }

  Widget buildSearchWidget() {
    return new Text("aa");
  }

  @override
  HomePresenter newInstance() {
    return HomePresenter();
  }
}
