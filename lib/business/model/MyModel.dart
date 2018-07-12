import 'dart:async';

import 'package:fun_subway/business/beans/LoginBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';

class MyModel extends BaseModel {
  LoginBean mLoginBean;

  void setLoginBean(LoginBean loginBean){
    this.mLoginBean = loginBean;
  }

  LoginBean getLoginBean(){
    return mLoginBean;
  }

  bool isLogin() {
    return mLoginBean != null && mLoginBean.user != null;
  }

  Future<ResponseBean<LoginBean>> fetchUserInfo(){
    return null;
  }
}
