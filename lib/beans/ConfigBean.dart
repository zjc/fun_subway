import 'package:fun_subway/beans/BaseBean.dart';

class ConfigBean extends BaseBean {
  final String download;
  final String agreement;
  final String post;
  final String about;
  final String topic;
  final String secret;
  final String user;
  final bool makeNotice;
  ConfigBean({this.download,this.agreement,this.post,this.about,this.topic,this.secret,this.user,this.makeNotice});

  factory ConfigBean.fromJson(Map<String, dynamic> json) {
    return ConfigBean(
        download: json['download'],
        agreement: json['agreement'],
        post: json['post'],
        about: json['about'],
        topic: json['topic'],
        secret: json['secret'],
        user: json['user'],
        makeNotice: json['makeNotice']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'download': download,
        'agreement': agreement,
        'post': post,
        'about': about,
        'topic': topic,
        'secret': secret,
        'user': user,
        'makeNotice': makeNotice,
      };
}
