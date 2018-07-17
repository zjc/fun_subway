import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
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

class UIUtils {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

class Math {
  static int min(int a, int b) {
    return (a <= b) ? a : b;
  }
}

class TextUtils {
  static isEmpty(String str) {
    if (str == null || str.isEmpty || "" == str.trim()) {
      return true;
    }
    return false;
  }

  static equals(String value1, String value2) {
    return value1 == value2;
  }

  static isPhoneNum(String str) {
    if (isEmpty(str)) {
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
