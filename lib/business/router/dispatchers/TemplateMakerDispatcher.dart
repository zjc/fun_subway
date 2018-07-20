import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_subway/business/constants/Constants.dart';
import 'package:fun_subway/business/router/FunRouter.dart';
import 'package:fun_subway/business/router/dispatchers/Dispatcher.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';

class TemplateMakerDispatcher implements Dispatcher {
  @override
  void dispatch(BuildContext context, String params) {
    FunRouter.navigateToLoginInterceptor(context, () {
      FunRouteFactory.go2WebView(context, "", Constants.MAKE_EXPRESSION, false);
    });
  }

  @override
  void dispatchAction(BuildContext context, VoidCallback action) {}
}
