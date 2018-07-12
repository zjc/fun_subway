import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/business/beans/LoginTypeBean.dart';
import 'package:fun_subway/business/beans/UserBean.dart';

class LoginBean extends BaseBean {
  final List<LoginTypeBean> logins;

  final UserBean user;

  LoginBean({this.logins, this.user});

  factory LoginBean.fromJson(Map<String, dynamic> map) {
    return LoginBean(
        logins: LoginTypeBean.instanceLoginTypeBean(map["logins"]),
        user: UserBean.fromJson(map["user"]));
  }

  Map<String, dynamic> toJson() => {
        "logins": logins,
        "user": user,
      };
}
