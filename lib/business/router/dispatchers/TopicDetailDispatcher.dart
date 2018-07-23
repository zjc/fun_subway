import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_subway/business/router/dispatchers/Dispatcher.dart';
import 'dart:convert';

import 'package:fun_subway/utils/FunRouteFactory.dart';

class TopicDetailDispatcher implements Dispatcher {
  @override
  void dispatch(BuildContext context, String params) {
    try {
      Map<String, dynamic> map = json.decode(params);
      int postId = map["topicName"];
      FunRouteFactory.go2PostDetail(context, postId);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispatchAction(BuildContext context, VoidCallback action) {}
}
