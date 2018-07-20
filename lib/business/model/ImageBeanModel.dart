import 'dart:async';

import 'package:fun_subway/business/beans/ImageListBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';

class ImageBeanModel extends BaseModel {
  //获取我的作品
  Future<ResponseBean<ImageListBean>> fetchMyProduct(
      int pageNum, int pageSize) async {
    Map<String, Object> params = {"page": pageNum, "pageSize": pageSize};
    try {
      Map<String, dynamic> map = await get(Api.MY_WORKS, params);
      ImageListBean bean = ImageListBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //删除我的作品
  Future<ResponseBean<String>> deleteProduct(String imageIds) async {
    Map<String, Object> params = {"imageIds": imageIds};
    try {
      Map<String, dynamic> map = await delete(Api.MY_WORKS, params);
      String bean = map["data"];
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //获取我的收藏
  Future<ResponseBean<ImageListBean>> fetchCollection(
      int pageNum, int pageSize) async {
    Map<String, Object> params = {"page": pageNum, "pageSize": pageSize};
    try {
      Map<String, dynamic> map = await get(Api.COLLECTION_LIST, params);
      ImageListBean bean = ImageListBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //删除我的收藏
  Future<ResponseBean<String>> deleteCollection(String imageIds) async {
    Map<String, Object> params = {"imageIds": imageIds};
    try {
      Map<String, dynamic> map = await delete(Api.DELETE_COLLECTION, params);
      String bean = map["data"];
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //收藏图片
  Future<ResponseBean<String>> collectImages(String imageIds) async {
    Map<String, Object> params = {"imageIds": imageIds};
    try {
      Map<String, dynamic> map = await post(Api.COLLECT, params);
      String bean = map["data"];
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }
}
