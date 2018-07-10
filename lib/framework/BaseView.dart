import 'package:flutter/material.dart';

abstract class BaseView {
  Widget showLoading();

  void showSnackbar(String desc,String buttonName,String action);

  Widget showError();
}
