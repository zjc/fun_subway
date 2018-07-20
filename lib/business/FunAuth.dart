import 'package:fun_subway/business/beans/LoginBean.dart';
import 'package:fun_subway/business/constants/Constants.dart';
import 'package:fun_subway/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FunAuth {
  static final FunAuth _singleton = new FunAuth._internal();

  factory FunAuth() {
    return _singleton;
  }

  FunAuth._internal();

  LoginBean mLoginBean;

  bool isLogin(){
    return mLoginBean != null;
  }

  void saveAuth(LoginBean loginBean) async {
    if (loginBean != null && loginBean.user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.USER_ID, loginBean.user.id.toString());
      if (!TextUtils.isEmpty(loginBean.user.apiToken)) {
        prefs.setString(Constants.API_TOKEN, loginBean.user.apiToken);
      }
      String hashCode =
          Utils.generateMd5(loginBean.user.nickname + Constants.APP_SECRET);
      prefs.setString(hashCode, json.encode(loginBean));
      prefs.setString(Constants.SHARED_USER_TOKEN, hashCode);
      mLoginBean = loginBean;
    }
  }

  void doAuthVerify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.SHARED_USER_TOKEN);
    if (!TextUtils.isEmpty(token)) {
      String userCenterBeanString = prefs.getString(token);
      LoginBean loginBean =
          LoginBean.fromJson(json.decode(userCenterBeanString));
      if (loginBean != null &&
          loginBean.user != null &&
          loginBean.user.active == 1) {
        mLoginBean = loginBean;
      } else {
        logout();
      }
    } else {
      logout();
    }
  }

  void logout() async {
    mLoginBean = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Constants.SHARED_USER_TOKEN);
    prefs.setString(Constants.USER_ID, "");
    prefs.setString(Constants.API_TOKEN, "");
    prefs.setString(token, "");
    prefs.setString(Constants.SHARED_USER_TOKEN, "");
  }
}
