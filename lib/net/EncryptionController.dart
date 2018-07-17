import 'dart:async';
import 'dart:collection';
import 'package:fun_subway/business/constants/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fun_subway/utils/utils.dart';
import 'package:fun_subway/net/RequestStuff.dart';

class EncryptionController {
  Future<RequestStuff> handle(
      String partUrl, Map<String, Object> params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.get(Constants.UUID);
    if (uuid == null || uuid.isEmpty) {
      uuid = DeviceInfo.getUUID();
      prefs.setString(Constants.UUID, uuid);
    }

    var st = new SplayTreeMap<String, Object>();
//    st["appSecret"] = Constants.APP_SECRET;
    st["deviceToken"] = uuid;
    st["timestamp"] = DateTime.now().millisecondsSinceEpoch;
    st["url"] = partUrl;
    st["version"] = "2.0.4";

    String userId = prefs.getString(Constants.USER_ID);
    if (userId != null && userId.isNotEmpty) {
      st["userId"] = userId;
    }

    //将请求参数提取，进行一同加密
    if (params != null && params.isNotEmpty) {
      for (var key in params.keys) {
        st[key] = Uri.encodeQueryComponent(params[key].toString());
      }
    }

    RequestStuff requestStuff = new RequestStuff();

    //打印要加密的集合，生成string
    var builder = new StringBuffer();
    for (var key in st.keys) {
      builder.write(key);
      builder.write("=");
      builder.write(st[key]);
      builder.write("&");
      requestStuff.addHeader(key, st[key]);
    }

    String decryptContent = builder.toString().substring(0, builder.length - 1);
    String encryptedToken = Utils.generateMd5(decryptContent);

    requestStuff.addHeader("appKey", "android");
    requestStuff.addHeader("token", encryptedToken);
    String apiToken = prefs.getString(Constants.API_TOKEN);
    if (apiToken == null || apiToken.isEmpty) {
      requestStuff.addHeader("atoken", encryptedToken);
    } else {
      String encryptedAToken = Utils.generateMd5(apiToken + decryptContent);
      requestStuff.addHeader("atoken", encryptedAToken);
    }
    return requestStuff;
  }
}
