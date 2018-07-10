import 'dart:async';

import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/beans/ResponseBean.dart';
import 'package:fun_subway/beans/ConfigBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';

class SplashModel extends BaseModel {
  Future<ResponseBean<ConfigBean>> fetchConfig() async {
    Map<String, dynamic> map = await get(Api.COMMON_CONFIG, null);
    try {
      ConfigBean configBean = ConfigBean.fromJson(map["data"]);
      return newSuccessResponseBean(
          map["code"], configBean, map["error_reason"]);
    } catch (exception) {
      return newErrorResponseBean(null, "-1000", "服务器响应失败");
    }
  }
}
