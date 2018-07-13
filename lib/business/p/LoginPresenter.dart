import 'package:fun_subway/business/model/LoginModel.dart';
import 'package:fun_subway/business/view/LoginView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class LoginPresenter extends BasePresenter<LoginView, LoginModel> {
  @override
  LoginModel newInstance() {
    return new LoginModel();
  }

  void loginByPwd(String phone,String pwd){

  }

  void loginByCode(String phone,String code){

  }

  void fetchVerifyCode(String phone){

  }
}
