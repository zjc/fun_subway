import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/framework/LoadMoreView.dart';

abstract class TopicDetailView extends LoadMoreView{
    void getTopicDetail(TopicBean topicBean);

    void getPosts(List<PostBean> posts);
}