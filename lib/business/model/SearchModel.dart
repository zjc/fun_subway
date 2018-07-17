import 'dart:async';

import 'package:fun_subway/business/beans/AssociationTagBean.dart';
import 'package:fun_subway/business/beans/HotSearchBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/business/beans/SearchResult.dart';
import 'package:fun_subway/business/beans/TopicOnlyNameBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';

class SearchModel extends BaseModel {
  Future<ResponseBean<HotSearchBean>> fetchHotSearch() async {
    Map<String, Object> params = {"pageSize": "10"};
    try {
      Map<String, dynamic> map = await get(Api.HOT_SEARCH, params);
      HotSearchBean bean = HotSearchBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  Future<ResponseBean<TopicOnlyNameBean>> fetchHotTopic() async {
    Map<String, Object> params = {"pageSize": "10"};
    try {
      Map<String, dynamic> map = await get(Api.TOPIC_LIST, params);
      TopicOnlyNameBean bean = TopicOnlyNameBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  Future<ResponseBean<AssociationTagBean>> fetchAssociation(String tag) async {
    Map<String, Object> params = {"tag": tag};
    try {
      Map<String, dynamic> map = await get(Api.SEARCH_ASSOCIATION, params);
      AssociationTagBean bean = AssociationTagBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  Future<ResponseBean<SearchResult>> fetchSearchResult(
      String tag, int pageNum, int pageSize) async {
    return fetchSearchResultByCheck(tag, pageNum, pageSize, null);
  }

  Future<ResponseBean<SearchResult>> fetchSearchResultByCheck(
      String tag, int pageNum, int pageSize, bool check) async {
    Map<String, Object> params = {
      "tag": tag,
      "page": pageNum,
      "pageSize": pageSize
    };
    if (check != null) {
      params["check"] = check;
    }
    try {
      Map<String, dynamic> map = await get(Api.SEARCH_RESULT_LIST, params);
      SearchResult bean = SearchResult.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }
}
