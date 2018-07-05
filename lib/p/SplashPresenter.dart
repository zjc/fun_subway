import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/view/SplashView.dart';
import 'package:fun_subway/model/SplashModel.dart';
import 'dart:convert';
import 'package:fun_subway/utils/utils.dart';

class SplashPresenter extends BasePresenter<SplashView, SplashModel> {
  @override
  SplashModel newInstance() {
    return new SplashModel();
  }

  void fetchConfig() {
    getModel().fetchConfig().then((responseBean) {
      String configJson = json.encode(responseBean.data);
      print("==========>json:" + configJson);
      SharedPreferenceUtils.setString("config", configJson);
      getView().fetchConfigSuccess();
    });
  }
}
