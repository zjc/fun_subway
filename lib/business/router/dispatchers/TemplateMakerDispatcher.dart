import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_subway/business/constants/Constants.dart';
import 'package:fun_subway/business/router/FunRouter.dart';
import 'package:fun_subway/business/router/dispatchers/Dispatcher.dart';
import 'package:fun_subway/plugins/flutter_webview_plugin.dart';

class TemplateMakerDispatcher implements Dispatcher {
  @override
  void dispatch(BuildContext context, String params) {
    FunRouter.navigateToLoginInterceptor(context, () {
//      FunRouteFactory.go2WebView(context, "", Constants.MAKE_EXPRESSION, false);
      double statusBarHeight = MediaQuery.of(context).padding.top;
      if(statusBarHeight == 0.0){
        statusBarHeight = 24.0;
      }
      print("statusBarHeight:"+statusBarHeight.toString());
      final flutterWebviewPlugin = new FlutterWebviewPlugin();
      flutterWebviewPlugin.launch(Constants.MAKE_EXPRESSION, rect: new Rect.fromLTWH(0.0, statusBarHeight, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height-statusBarHeight));
    });
  }

  @override
  void dispatchAction(BuildContext context, VoidCallback action) {}
}
