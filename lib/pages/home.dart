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
    Widget bannerWidget = _buildBannerWidget();
    return new Scaffold(
        appBar: new AppBar(
          title: _buildSearchWidget(),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: bannerWidget);
  }

  Widget _buildSearchWidget() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new OutlineButton.icon(
            onPressed: () {
              //TODO 跳转到search界面
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            borderSide: new BorderSide(color: Colors.grey),
            icon: new Icon(Icons.search),
            label: new Text("搜索你想要的表情"),
          )),
      ],
    );
  }
  @override
  initState(){
    super.initState();
    mPresenter.fetchHomeData();

  }

  Widget _buildBannerWidget() {
    return new Text("aaaaa");

  }

  @override
  HomePresenter newInstance() {
    return HomePresenter();
  }
}
