import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/business/view/SplashView.dart';
import 'package:fun_subway/business/model/SplashModel.dart';
import 'dart:convert';
import 'package:fun_subway/utils/utils.dart';

class SplashPresenter extends BasePresenter<SplashView, SplashModel> {
  @override
  SplashModel newInstance() {
    return new SplashModel();
  }

  void fetchConfig() {
    getModel().fetchConfig().then((responseBean) {
      SharedPreferenceUtils.setString("config", json.encode(responseBean.data));
      getView().fetchConfigSuccess();
    }, onError: (e) {
      getView().fetchConfigSuccess();
    });
  }
}
