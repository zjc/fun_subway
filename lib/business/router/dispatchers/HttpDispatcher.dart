import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_subway/business/router/dispatchers/Dispatcher.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';

class HttpDispatcher implements Dispatcher{
  @override
  void dispatch(BuildContext context, String params) {
    FunRouteFactory.go2WebViewPage(context, "", params);
  }

  @override
  void dispatchAction(BuildContext context, VoidCallback action) {

  }
}