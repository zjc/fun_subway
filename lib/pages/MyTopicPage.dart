import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/business/p/MyTopicPresenter.dart';
import 'package:fun_subway/business/view/MyTopicView.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';

//我关注的话题
class MyTopicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyTopicState();
  }
}

class MyTopicState extends LoadMoreState<MyTopicPresenter, MyTopicPage>
    implements MyTopicView {
  List<TopicBean> _dataSource = [];

  @override
  void initState() {
    super.initState();
    mPresenter.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: defaultSimpleAppBar("我的话题"),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_dataSource == null || _dataSource.isEmpty) {
      return showLoading();
    } else {
      return ListView.builder(
        itemCount: _dataSource.length,
        itemBuilder: (context, position) {
          TopicBean topicBean = _dataSource[position];
          return new ListTile(
              leading: Image.network(
                topicBean.background,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              title: new Text(
                topicBean.name,
                style: new TextStyle(color: FunColors.c_333, fontSize: 16.0),
              ),
              subtitle: new Text(topicBean.followCount.toString() +
                  "关注者  " +
                  topicBean.discussCount.toString() +
                  "讨论"),
              trailing: new Icon(Icons.keyboard_arrow_right),
              onTap: () {
                FunRouteFactory.go2TopicDetailPage(context, topicBean.name);
              });
        },
      );
    }
  }

  @override
  MyTopicPresenter newInstance() {
    return new MyTopicPresenter();
  }

  @override
  void getMyTopics(List<TopicBean> topicBeans) {
    if (topicBeans != null && topicBeans.isNotEmpty) {
      setState(() {});
      _dataSource.addAll(topicBeans);
    }
  }
}
