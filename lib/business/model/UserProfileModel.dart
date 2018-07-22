import 'dart:async';

import 'package:fun_subway/business/beans/FollowBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';

class UserProfileModel extends BaseModel{
  Future<ResponseBean<FollowBean>> follow(int followId) async{
    Map<String, Object> params = {"followId": followId};
    try {
      Map<String, dynamic> map = await post(Api.USER_FOLLOW, params);
      FollowBean bean = FollowBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  Future<ResponseBean<FollowBean>> unFollow(int followId) async {
    Map<String, Object> params = {"followId": followId};
    try {
      Map<String, dynamic> map = await delete(Api.USER_FOLLOW, params);
      FollowBean bean = FollowBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }
}