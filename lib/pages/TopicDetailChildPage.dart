import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/business/p/TopicDetailPresenter.dart';
import 'package:fun_subway/business/view/TopicDetailView.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/widget/PostWidget.dart';

class TopicDetailChildPage extends StatefulWidget {
  int type = 0; // 0:最热 1:最新
  String topicName;

  TopicDetailChildPage(this.type, this.topicName);

  @override
  State<StatefulWidget> createState() {
    return new TopicDetailChildState();
  }
}

class TopicDetailChildState
    extends LoadMoreState<TopicDetailPresenter, TopicDetailChildPage>
    implements TopicDetailView {
  List<PostBean> _dataSource = [];

  @override
  void initState() {
    super.initState();
    mPresenter.setType(widget.type);
    mPresenter.setTopicName(widget.topicName);
    mPresenter.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    if (_dataSource == null || _dataSource.isEmpty) {
      return showLoading();
    } else {
      return ListView.builder(
          itemCount: _dataSource.length,
          itemBuilder: (context, index) {
            return new PostWidget(
                _dataSource[index], PostWidget.SOURCE_TYPE_TOPIC);
          });
    }
  }

  @override
  TopicDetailPresenter newInstance() {
    return new TopicDetailPresenter();
  }

  @override
  void getTopicDetail(TopicBean topicBean) {}

  @override
  void getPosts(List<PostBean> posts) {
    if (posts != null && posts.isNotEmpty) {
      setState(() {
        _dataSource.addAll(posts);
      });
    }
  }
}
