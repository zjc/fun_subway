import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/framework/LoadMoreView.dart';

abstract class MyTopicView extends LoadMoreView {
  void getMyTopics(List<TopicBean> topicBeans);
}