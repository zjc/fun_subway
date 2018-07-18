import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/business/beans/CommentBean.dart';

class CommentsBean extends BaseBean {
  final List<CommentBean> comments;

  CommentsBean({this.comments});

  factory CommentsBean.fromJson(Map<String, dynamic> map) {
    List list = map["comments"];
    List<CommentBean> comments;
    if (list != null && list.isNotEmpty) {
      comments = list.map((map) {
        return CommentBean.fromJson(map);
      }).toList();
    }
    return CommentsBean(comments: comments);
  }

  Map<String, dynamic> toJson() => {
        "comments": comments,
      };
}
