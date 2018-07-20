import 'dart:async';
import 'dart:convert';

import 'package:fun_subway/business/beans/HomeFeedBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';

class HomeModel extends BaseModel {
  Future<ResponseBean<HomeFeedBean>> fetchFeedList(
      int pageNum, int pageSize) async {
    Map<String, Object> params = {"page": pageNum, "pageSize": pageSize};
    try {
      Map<String, dynamic> map = await get(Api.HOME_FEED, params);
      HomeFeedBean homeFeedBean = HomeFeedBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], homeFeedBean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }
}
