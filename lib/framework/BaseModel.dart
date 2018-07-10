import 'dart:io';

import 'package:fun_subway/beans/ResponseBean.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fun_subway/net/Api.dart';
import 'package:fun_subway/net/EncryptionController.dart';
import 'dart:convert';

abstract class BaseModel {
  Future<Map<String, dynamic>> get(
      String partUrl, Map<String, Object> params) async {
    EncryptionController controller = new EncryptionController();
    var requestStuff = await controller.handle(partUrl, params);
    Map<String, String> headerMap = requestStuff.headerMap;
    String newUrl = operateUrl(Api.BASE_URL + partUrl, headerMap);
    try {
      final response = await http.get(newUrl, headers: headerMap);
      return json.decode(response.body.toString());
    } catch (exception) {
      print("exception:" + exception.toString());
    }
  }

  ResponseBean<T> newSuccessResponseBean<T>(
      String code, T data, String error_reason) {
    if (code == "0000") {
      return new ResponseBean(code: code, data: data);
    } else {
      return newErrorResponseBean(data, code, error_reason);
    }
  }

  ResponseBean<T> newErrorResponseBean<T>(
      T data, String error_code, String error_reason) {
    return new ResponseBean(
        data: data, error_code: error_code, error_reason: error_reason);
  }

  String operateUrl(String url, Map<String, String> map) {
    var builder = new StringBuffer(url);
    builder.write("?");
    for (var key in map.keys) {
      builder.write(key);
      builder.write("=");
      builder.write(map[key]);
      builder.write("&");
    }
    return builder.toString().substring(0, builder.length - 1);
  }
}
