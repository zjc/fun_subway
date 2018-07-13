import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:shared_preferences/shared_preferences.dart';

class DeviceInfo {
  static String getUUID() {
    var uuid = new Uuid();
    return uuid.v1();
  }
}

class Utils {
  ///Generate MD5 hash
  static generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}

class TextUtils {
  static isEmpty(String str) {
    if (str == null || str.isEmpty || "" == str.trim()) {
      return true;
    }
    return false;
  }

  static isPhoneNum(String str){
    if(isEmpty(str)){
      return false;
    }
    RegExp mobile = new RegExp(r"(0|86)?(1)[0-9]{10}");
    return mobile.hasMatch(str);
  }
}

class SharedPreferenceUtils {
  static void setString(String key, String object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, object);
  }

  static dynamic get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
