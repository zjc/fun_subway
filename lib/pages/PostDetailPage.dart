import 'package:flutter/material.dart';
import 'package:fun_subway/business/p/PostDetailPresenter.dart';
import 'package:fun_subway/framework/BaseState.dart';

class PostDetailPage extends StatefulWidget {

  int postId;

  PostDetailPage(this.postId);

  @override
  State<StatefulWidget> createState() {
    return new PostDetailState();
  }
}

class PostDetailState extends BaseState<PostDetailPresenter,PostDetailPage>{
  @override
  Widget build(BuildContext context) {
    return new Text("aa");
  }

  @override
  PostDetailPresenter newInstance() {
    return new PostDetailPresenter();
  }

}