import 'dart:async';

import 'package:fun_subway/business/beans/FollowedTopicBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/business/beans/TopicDetailBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';

class TopicModel extends BaseModel {
  //获取我关注的topic
  Future<ResponseBean<FollowedTopicBean>> fetchMyFollowTopics(
      int page, int pageSize) async {
    Map<String, Object> params = {"page": page, "pageSize": pageSize};
    try {
      Map<String, dynamic> map = await get(Api.TOPIC_FOLLOW, params);
      FollowedTopicBean bean = FollowedTopicBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //Topic详情
  Future<ResponseBean<TopicBean>> fetchTopicDetail(String name) async {
    Map<String, Object> params = {"name": name};
    try {
      Map<String, dynamic> map = await get(Api.TOPIC_DETAIL, params);
      TopicBean bean = TopicBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //获取热门帖子
  Future<ResponseBean<TopicDetailBean>> loadHotTopic(
      String name, int pageNum, int pageSize) async {
    Map<String, Object> params = {
      "name": name,
      "page": pageNum,
      "pageSize": pageSize
    };

    try {
      Map<String, dynamic> map = await get(Api.HOTTEST_TOPIC, params);
      TopicDetailBean bean = TopicDetailBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //获取最新帖子
  Future<ResponseBean<TopicDetailBean>> loadNewTopic(
      String name, int pageNum, int pageSize) async {
    Map<String, Object> params = {
      "name": name,
      "page": pageNum,
      "pageSize": pageSize
    };

    try {
      Map<String, dynamic> map = await get(Api.NEW_TOPIC, params);
      TopicDetailBean bean = TopicDetailBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //关注
  Future<ResponseBean<String>> followTopic(int topicId) async {
    Map<String, Object> params = {"topicId": topicId};
    try {
      Map<String, dynamic> map = await get(Api.TOPIC_FOLLOW, params);
      String bean = map["data"];
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  //取消关注
  Future<ResponseBean<String>> unFollowTopic(int topicId) async {
    Map<String, Object> params = {"topicId": topicId};
    try {
      Map<String, dynamic> map = await delete(Api.TOPIC_FOLLOW, params);
      String bean = map["data"];
      return newResponseBean(
          map["code"], bean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }
}
