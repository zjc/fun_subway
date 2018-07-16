import 'package:fun_subway/business/beans/BaseBean.dart';

class TopicOnlyNameBean extends BaseBean {
  final List<String> topicNames;

  TopicOnlyNameBean({this.topicNames});

  factory TopicOnlyNameBean.fromJson(Map<String, dynamic> json) {
    return TopicOnlyNameBean(
        topicNames: BaseBean.instanceStringList(json["topicNames"]));
  }

  Map<String, dynamic> toJson() => {
        "topicNames": topicNames,
      };
}
