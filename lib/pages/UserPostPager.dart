import 'package:flutter/material.dart';
import 'package:fun_subway/business/p/UserPostPresenter.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';

class UserPostPager extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new UserPostState();
  }
}

class UserPostState extends LoadMoreState<UserPostPresenter,UserPostPager>{
  @override
  Widget build(BuildContext context) {
    return new Text("User Post");
  }

  @override
  UserPostPresenter newInstance() {
    return new UserPostPresenter();
  }

  @override
  void refreshData() {

  }

}