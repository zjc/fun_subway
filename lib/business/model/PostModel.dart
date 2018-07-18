import 'dart:async';

import 'package:fun_subway/business/beans/CommentsBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';

class PostModel extends BaseModel {
  Future<ResponseBean<PostBean>> fetchPost(int postId) async {
    try {
      Map<String, Object> params = {"id": postId};
      Map<String, dynamic> map = await get(Api.POST_DETAIL, params);
      PostBean bean = PostBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }


  Future<ResponseBean<CommentsBean>> fetchComments(int postId,int id) async {
    try {
      Map<String, Object> params = {"postId": postId, "pageSize": 10};
      if(id != null && id != 0){
        params["id"] = id;
      }
      Map<String, dynamic> map = await get(Api.COMMENT, params);
      CommentsBean bean = CommentsBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }
}
