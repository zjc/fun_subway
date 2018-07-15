import 'dart:async';

import 'package:fun_subway/business/beans/MakerBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';

class MakeModel extends BaseModel {
  Future<ResponseBean<MakerBean>> fetchMakeMenu() async {
    try {
      Map<String, dynamic> map = await get(Api.MAKE_MENU, null);
      MakerBean makerBean = MakerBean.fromJson(map["data"]);
      return newResponseBean(
          map["code"], makerBean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }
}
