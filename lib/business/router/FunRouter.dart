import 'package:flutter/material.dart';
import 'package:fun_subway/business/router/DispatcherRepository.dart';
import 'package:fun_subway/business/router/FunAction.dart';
import 'package:fun_subway/business/router/dispatchers/Dispatcher.dart';
import 'package:fun_subway/utils/utils.dart';
import 'FunScheme.dart';

class FunRouter {
  static void navigateToLoginInterceptor(BuildContext context, VoidCallback callback) {
    Dispatcher dispatcher =
        DispatcherRepository().queryActionDispatcher(FunAction.LOGIN_INTERCEPT);
    if (dispatcher != null) {
      dispatcher.dispatchAction(context, callback);
    }
  }

  static bool navigate(BuildContext context, String url) {
    if (TextUtils.isEmpty(url)) {
      return false;
    }

    if (url.startsWith(FunScheme.HTTP)) {
      //网页
      Dispatcher dispatcher =
          DispatcherRepository().querySchemeDispatcher(FunScheme.HTTP);
      if (dispatcher != null) {
        dispatcher.dispatch(context, url);
        return true;
      }
    } else if (url.startsWith(FunScheme.SOQU)) {
      Uri uri = Uri.parse(url);
      String host = uri.host;
      String body = uri.query;
      String params = "";
      if (!TextUtils.isEmpty(body)) {
        params = body.replaceAll("body=", "");
      }

      Dispatcher dispatcher =
          DispatcherRepository().querySchemeDispatcher(host);
      if (dispatcher != null) {
        dispatcher.dispatch(context, params);
        return true;
      }
    }

    return false;
  }
}
