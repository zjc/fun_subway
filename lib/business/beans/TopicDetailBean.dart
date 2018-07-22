import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';

class TopicDetailBean extends BaseBean {
  final int page;

  final List<PostBean> posts;

  TopicDetailBean({this.page, this.posts});

  factory TopicDetailBean.fromJson(Map<String, dynamic> json) {
    List list = json["posts"];
    List<PostBean> posts;
    if (list != null && list.isNotEmpty) {
      posts = list.map((map) {
        return PostBean.fromJson(map);
      }).toList();
    }

    int page = json["page"];

    return TopicDetailBean(page: page, posts: posts);
  }

  Map<String, dynamic> toJson() => {
        "page": page,
        "posts": posts,
      };
}
