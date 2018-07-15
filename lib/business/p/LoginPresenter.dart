import 'package:fun_subway/business/beans/LoginBean.dart';
import 'package:fun_subway/business/model/LoginModel.dart';
import 'package:fun_subway/business/view/LoginView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class LoginPresenter extends BasePresenter<LoginView, LoginModel> {
  @override
  LoginModel newInstance() {
    return new LoginModel();
  }

  LoginBean mLoginBean;

  void loginByPwd(String phone, String pwd) {
    model.loginByPwd(phone, pwd).then((responseBean) {
      mLoginBean = responseBean.data;
      if (getView() != null) {
        getView().loginSuccess(mLoginBean);
      }
    });
  }

  void loginByCode(String phone, String code) {
    model.loginByVerifyCode(phone, code).then((responseBean) {
      mLoginBean = responseBean.data;

      if (getView() != null) {
        if (mLoginBean.user.active == 1) {
          getView().loginSuccess(mLoginBean);
        } else {
          getView().loginByMessageCodeUnregisterCallBack(mLoginBean.user);
        }
      }
    });
  }

  //通过第三方登录
  void loginByThirdPart() {

  }

  void fetchVerifyCode(String phone) {
    model.fetchVerifyCode(phone, "1", "0").then((responseBean) {
      if (responseBean.isSuccess()) {
        if (getView() != null) {
          getView().sendVerifyCodeSuccess();
        }
      }
    });
  }
}
