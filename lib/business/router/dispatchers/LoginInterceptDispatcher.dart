import 'package:flutter/material.dart';
import 'package:fun_subway/business/FunAuth.dart';
import 'package:fun_subway/business/router/dispatchers/Dispatcher.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';

class LoginInterceptDispatcher implements Dispatcher {
  @override
  void dispatch(BuildContext context, String params) {}

  @override
  void dispatchAction(BuildContext context, VoidCallback callback) {
    if (FunAuth().isLogin()) {
      //已登录，直接出发action动作
      if (callback != null) {
        callback();
      }
    } else {
      FunRouteFactory.go2LoginPage(context).then((loginBean) {
        if (loginBean != null) {
          //登录成功
          if (callback != null) {
            callback();
          }
        }
      });
    }
  }
}
