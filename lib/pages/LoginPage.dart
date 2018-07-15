import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/LoginBean.dart';
import 'package:fun_subway/business/beans/UserBean.dart';
import 'package:fun_subway/business/p/LoginPresenter.dart';
import 'package:fun_subway/business/view/LoginView.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginData {
  String phone = '';
  String password = '';
  String verificationCode = '';
}

class LoginState extends BaseState<LoginPresenter, LoginPage>
    implements LoginView {
  final GlobalKey<FormState> _LoginKey = new GlobalKey<FormState>();

  LoginData loginData = new LoginData();

  String _validateAccount(String value) {
    if (TextUtils.isEmpty(value) || !TextUtils.isPhoneNum(value)) {
      return "请输入正确的手机号";
    }
    return null;
  }

  String _validatePwd(String value) {
    return _validateEmpty(value, "请输入密码");
  }

  String _validateVerificationCode(String value) {
    return _validateEmpty(value, "请输入短信验证码");
  }

  String _validateEmpty(String value, String tips) {
    if (TextUtils.isEmpty(value)) {
      return tips;
    }
    return null;
  }

  final TextEditingController _AccountController = new TextEditingController();
  final TextEditingController _PwdController = new TextEditingController();
  final TextEditingController _VerificationCodeController =
      new TextEditingController();

  bool isAccountEmpty = true;
  bool isValidateCodeEmpty = true;
  bool isPwdShowing = false;

  bool showPassword = false;

  bool isPwdLoginModel = false; //是否是密码登录模式

  String titleName = "短信登录";

  Widget _buildAccountRow() {
    _AccountController.addListener(() {
      String text = _AccountController.text;
      setState(() {
        isAccountEmpty = TextUtils.isEmpty(text);
      });
    });
    return new Flexible(
      child: new Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
        child: new TextFormField(
          style: new TextStyle(fontSize: 16.0, color: FunColors.c_333),
          keyboardType: TextInputType.phone,
          validator: _validateAccount,
          onSaved: (String value) {
            loginData.phone = value;
          },
          controller: _AccountController,
          decoration: InputDecoration(
            hintText: "请输入手机号码",
            hintStyle: new TextStyle(color: Colors.black54),
            border: new UnderlineInputBorder(),
            prefixIcon: new Icon(Icons.phone_android),
            suffixIcon: buildSuffixIcon(isAccountEmpty, _AccountController),
          ),
        ),
      ),
    );
  }

  Widget buildSuffixIcon(bool isEmpty, TextEditingController controller) {
    if (isEmpty) {
      return new Text("");
    }
    return new InkWell(
      child: new Icon(Icons.cancel),
      onTap: () {
        controller.clear();
      },
    );
  }

  Widget _buildPwdRow() {
    return new Flexible(
      child: new Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: new TextFormField(
          style: new TextStyle(fontSize: 16.0, color: FunColors.c_333),
          keyboardType: TextInputType.text,
          validator: _validatePwd,
          onSaved: (String value) {
            loginData.password = value;
          },
          obscureText: !showPassword,
          controller: _PwdController,
          decoration: InputDecoration(
              hintText: "请输入密码",
              hintStyle: new TextStyle(color: Colors.black54),
              border: new UnderlineInputBorder(),
              prefixIcon: new Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                  icon: Icon(
                      !showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  })),
        ),
      ),
    );
  }

  void _submit() {
    final FormState form = _LoginKey.currentState;
    if (form.validate()) {
      form.save();
      if (isPwdLoginModel) {
        mPresenter.loginByPwd(loginData.phone, loginData.password);
      } else {
        mPresenter.loginByCode(loginData.phone, loginData.verificationCode);
      }
    }
  }

  Widget _buildVerificationCodeRow() {
    _VerificationCodeController.addListener(() {
      String text = _VerificationCodeController.text;
      setState(() {
        isValidateCodeEmpty = TextUtils.isEmpty(text);
      });
    });

    return new Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Flexible(
            child: new TextFormField(
              style: new TextStyle(fontSize: 16.0, color: FunColors.c_333),
              keyboardType: TextInputType.number,
              validator: _validateVerificationCode,
              onSaved: (String value) {
                loginData.verificationCode = value;
              },
              controller: _VerificationCodeController,
              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.lock_outline),
                hintText: "请输入验证码",
                suffixIcon: buildSuffixIcon(
                    isValidateCodeEmpty, _VerificationCodeController),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: new OutlineButton(
              child: new Text(
                _verifyStr,
                style: new TextStyle(color: FunColors.c_666, fontSize: 14.0),
              ),
              onPressed: () {
                String phone = _AccountController.text;
                if (TextUtils.isEmpty(phone)) {
                  showToast("手机号不能为空!");
                  return;
                }
                //设置倒计时
                _startCountDown();
                mPresenter.fetchVerifyCode(phone);
              },
            ),
          )
        ],
      ),
    );
  }

  int _seconds = 0;
  Timer _timer;

  String _verifyStr = '获取验证码';

  void _startCountDown() {
    _seconds = 10;

    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }

      _seconds--;
      _verifyStr = '$_seconds(s)';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  Widget _buildLoginModel() {
    return new InkWell(
      child: new Center(
        child: new Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: new Text('${isPwdLoginModel ? "验证码登录" : "密码登录"}'),
        ),
      ),
      onTap: () {
        setState(() {
          isPwdLoginModel = !isPwdLoginModel;
          titleName = isPwdLoginModel ? "密码登录" : "验证码登录";
        });
      },
    );
  }

  Widget _buildLoginButton() {
    return new Center(
        child: new Container(
      width: 250.0,
      padding: EdgeInsets.only(top: 25.0),
      child: new RaisedButton(
        onPressed: _submit,
        child: new Text("立即登录",
            style: new TextStyle(color: Colors.white, fontSize: 16.0)),
        color: FunColors.themeColor,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          '${titleName}',
          style: new TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black87),
        elevation: 0.0,
      ),
      body: new Container(
        padding: EdgeInsets.only(left: 25.0, right: 25.0,top: 35.0),
        child: new Form(
          key: _LoginKey,
          autovalidate: false,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildAccountRow(),
              _buildSecondRow(),
              _buildLoginButton(),
              _buildLoginModel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondRow() {
    if (isPwdLoginModel) {
      return _buildPwdRow();
    } else {
      return _buildVerificationCodeRow();
    }
  }

  @override
  LoginPresenter newInstance() {
    return LoginPresenter();
  }

  @override
  void loginByMessageCodeUnregisterCallBack(UserBean userBean) {}

  @override
  void loginByThirdPartUnregisterCallBack(UserBean userBean) {}

  @override
  void loginSuccess(LoginBean loginBean) {
    Navigator.of(context).pop(loginBean);
  }

  @override
  void sendVerifyCodeSuccess() {
    showToast("短信验证码发送成功，请注意查收！");
  }
}
