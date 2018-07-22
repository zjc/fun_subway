import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';

class FollowedTopicBean extends BaseBean {
  final List<TopicBean> topics;

  FollowedTopicBean({this.topics});

  factory FollowedTopicBean.fromJson(Map<String, dynamic> json) {
    List<TopicBean> topics;
    List list = json["topics"];
    if (list != null && list.isNotEmpty) {
      topics = list.map((map) {
        return TopicBean.fromJson(map);
      }).toList();
    }
    return FollowedTopicBean(topics: topics);
  }
}
