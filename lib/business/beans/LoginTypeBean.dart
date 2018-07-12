import 'package:fun_subway/business/beans/BaseBean.dart';

class LoginTypeBean extends BaseBean {
  final String nickname;
  final int type;
  final int userId;

  LoginTypeBean({this.nickname, this.type, this.userId});

  factory LoginTypeBean.fromJson(Map<String, dynamic> map) {
    return LoginTypeBean(
        nickname: map["nickname"], type: map["type"], userId: map["userId"]);
  }

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "type": type,
        "userId": userId,
      };

  static instanceLoginTypeBean(List list) {
    List<LoginTypeBean> imageBeans;
    if (list != null && list.isNotEmpty) {
      imageBeans = list.map((map) {
        return LoginTypeBean.fromJson(map);
      }).toList();
    }
    return imageBeans;
  }
}
