import 'dart:async';

import 'package:fun_subway/business/FunAuth.dart';
import 'package:fun_subway/business/beans/LoginBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/business/constants/Constants.dart';
import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/net/Api.dart';
import 'package:fun_subway/utils/utils.dart';

class LoginModel extends BaseModel {
  Future<ResponseBean<LoginBean>> loginByPwd(String phone, String pwd) async {
    try {
      String newPwd =
          Utils.generateMd5(Constants.APP_SECRET + Utils.generateMd5(pwd));
      Map<String, Object> params = {"username": phone, "password": newPwd};
      Map<String, dynamic> map = await get(Api.LOGIN, params);
      LoginBean loginBean = LoginBean.fromJson(map["data"]);
      saveAuth(loginBean);
      return newResponseBean(
          map["code"], loginBean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  Future<ResponseBean<LoginBean>> loginByVerifyCode(
      String phone, String code) async {
    try {
      Map<String, Object> params = {"mobile": phone, "code": code};
      Map<String, dynamic> map = await get(Api.LOGIN_BY_VERIFY_CODE, params);
      LoginBean loginBean = LoginBean.fromJson(map["data"]);
      saveAuth(loginBean);
      return newResponseBean(
          map["code"], loginBean, map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  Future<ResponseBean> fetchVerifyCode(
      String mobile, String type, String codeType) async {
    try {
      Map<String, Object> params = {
        "mobile": mobile,
        "type": type,
        "codeType": codeType
      };
      Map<String, dynamic> map = await get(Api.VERIFY_CODE, params);
      return newResponseBean(
          map["code"], map["data"], map["error_code"], map["error_reason"]);
    } catch (exception) {
      throw exception;
    }
  }

  void saveAuth(LoginBean loginBean) {
    FunAuth().saveAuth(loginBean);
  }
}
