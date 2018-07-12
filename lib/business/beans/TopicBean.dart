import 'package:fun_subway/business/beans/BaseBean.dart';

///话题
class TopicBean extends BaseBean{
  final String background;
  final String intro;
  final String name;
  final int discussCount;//讨论
  final int followCount;//关注者
  final bool followed;
  final int id;
  TopicBean({this.background,this.intro,this.name,this.discussCount,this.followCount,this.followed,this.id});

  factory TopicBean.fromJson(Map<String,dynamic> json){
      return TopicBean(
        background: json["background"],
        intro: json["intro"],
        name: json["name"],
        discussCount: json["discussCount"],
        followCount: json["followCount"],
        followed: json["followed"],
        id: json["id"],
      );
  }
  Map<String, dynamic> toJson() =>
      {
        'background': background,
        'intro': intro,
        'name': name,
        'discussCount': discussCount,
        'followCount': followCount,
        'followed': followed,
        'id': id,
      };
}