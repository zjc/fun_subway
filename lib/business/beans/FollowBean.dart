import 'package:fun_subway/business/beans/BaseBean.dart';

class FollowBean extends BaseBean {
  final int followed;

  FollowBean({this.followed});

  factory FollowBean.fromJson(Map<String, dynamic> json) {
    return FollowBean(followed: json["followed"]);
  }

  Map<String, dynamic> toJson() => {
        "followed": followed,
      };
}
