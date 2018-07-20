import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_subway/business/router/dispatchers/Dispatcher.dart';
import 'dart:convert';

import 'package:fun_subway/utils/FunRouteFactory.dart';

class SearchDispatcher implements Dispatcher {
  @override
  void dispatch(BuildContext context, String params) {
    Map<String, dynamic> map = json.decode(params);
    String searchWord = map["searchWord"];
    FunRouteFactory.go2SearchPage(context, searchWord);
  }

  @override
  void dispatchAction(BuildContext context, VoidCallback action) {}
}
