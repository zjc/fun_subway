import 'package:fun_subway/business/beans/BaseBean.dart';

class UserBean extends BaseBean {
  final String birthday;
  final int id;
  final String nickname;
  final String profilePicture;
  final int sex;
  final int active;
  final int fansCount; //粉丝数
  final int followCount; //关注数
  final int followed; //关注状态 0:未关注 1：已关注 2：互相关注
  final String apiToken;
  final int messageCount;

  UserBean(
      {this.birthday,
      this.id,
      this.nickname,
      this.profilePicture,
      this.sex,
      this.active,
      this.fansCount,
      this.followCount,
      this.followed,
      this.apiToken,
      this.messageCount});

  factory UserBean.fromJson(Map<String, dynamic> json) {
    return UserBean(
      birthday: json["birthday"],
      id: json["id"],
      nickname: json["nickname"],
      profilePicture: json["profilePicture"],
      sex: json["sex"],
      active: json["active"],
      fansCount: json["fansCount"],
      followCount: json["followCount"],
      followed: json["followed"],
      apiToken: json["apiToken"],
      messageCount: json["messageCount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "birthday": birthday,
        "id": id,
        "nickname": nickname,
        "profilePicture": profilePicture,
        "sex": sex,
        "active": active,
        "fansCount": fansCount,
        "followCount": followCount,
        "followed": followed,
        "apiToken": apiToken,
        "messageCount": messageCount,
      };
}
