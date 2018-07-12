import 'dart:async';

import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/business/beans/ConfigBean.dart';
import 'package:fun_subway/net/Api.dart';

class SplashModel extends BaseModel {
  Future<ResponseBean<ConfigBean>> fetchConfig() async {
    try {
      Map<String, dynamic> map = await get(Api.COMMON_CONFIG, null);
      ConfigBean configBean = ConfigBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], configBean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }
}
