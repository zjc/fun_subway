import 'package:fun_subway/business/beans/LoginBean.dart';
import 'package:fun_subway/business/beans/UserBean.dart';
import 'package:fun_subway/framework/BaseView.dart';
abstract class LoginView extends BaseView{
    void loginSuccess(LoginBean loginBean);

    void loginByMessageCodeUnregisterCallBack(UserBean userBean);

    void loginByThirdPartUnregisterCallBack(UserBean userBean);


    void sendVerifyCodeSuccess();
}