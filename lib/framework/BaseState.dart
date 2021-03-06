import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/utils.dart';
import 'package:fun_subway/widget/CardImageItem.dart';
import 'package:fun_subway/widget/share/ShareWidget.dart';
import 'BaseView.dart';
import 'BasePresenter.dart';

abstract class BaseState<PRESENTER extends BasePresenter,
        STATEFUL_WIDGET extends StatefulWidget> extends State<STATEFUL_WIDGET>
    implements BaseView {
  //用于图片的显示方式
  bool isNetworkAvailable = true;
  bool isWifi = true;

  static const _toastPlatform =
      const MethodChannel('com.fun.framework.plugins/toast');

  static const _netUtils = const MethodChannel("com.fun.framework.plugins/net");

  void showToast(String message) {
    try {
      //调用相应方法，并传入相关参数。
      if (_toastPlatform != null) {
        _toastPlatform.invokeMethod('showShortToast', {'message': message});
      }
    } catch (exception) {
      print(exception);
    }
  }

  void showShareBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              child: new Padding(
            padding: const EdgeInsets.all(15.0),
            child: new ShareWidget([]),
          ));
        });
  }

  PRESENTER mPresenter;

  @override
  void initState() {
    super.initState();
    mPresenter = newInstance();
    mPresenter.bindView(this);
    initNetStatus();
  }

  void initNetStatus() async {
    try {
      isNetworkAvailable = await _netUtils.invokeMethod("isNetworkAvailable");
      isWifi = await _netUtils.invokeMethod("isWifi");
    } catch (e) {
      print(e.toString());
    }
  }

  PRESENTER newInstance();

  @override
  void dispose() {
    super.dispose();
    if (mPresenter != null) {
      mPresenter.onDestroy();
      mPresenter = null;
    }
  }

  @override
  Widget showLoading() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  void showSimpleSnackbar(String desc) {
    showSnackbar(desc, null, null);
  }

  @override
  void showSnackbar(String desc, String buttonName, String action) {
    var snackBar = new SnackBar(content: new Text(desc));
    if (!TextUtils.isEmpty(buttonName)) {
      snackBar = new SnackBar(
        content: new Text(desc),
        action: new SnackBarAction(
            label: buttonName,
            onPressed: () {
              //TODO snackBar action
            }),
      );
    }
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget showError() {
    return new Text("发生错误");
  }

  Widget buildRetry(String error, VoidCallback v) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            "images/ic_nonetwork.png",
            width: 183.0,
            height: 140.0,
            fit: BoxFit.cover,
          ),
          new Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: new Text(error,
                style: new TextStyle(color: Colors.black87, fontSize: 14.0)),
          ),
          new OutlineButton.icon(
              onPressed: v,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0)),
              icon: new Icon(Icons.refresh),
              label: new Text(
                "重新加载",
                style: new TextStyle(fontSize: 14.0, color: Colors.black87),
              ))
        ],
      ),
    );
  }

  Widget buildDivider(double height) {
    return new Container(
      color: Color.fromARGB(255, 244, 244, 244),
      height: height,
    );
  }

  PreferredSizeWidget defaultAppBar(String title, List<Widget> actions) {
    return new AppBar(
      title: new Text(
        title,
        style: new TextStyle(color: FunColors.c_333, fontSize: 18.0),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: new IconThemeData(color: Colors.black87),
      actions: actions,
    );
  }

  PreferredSizeWidget defaultSimpleAppBar(String title) {
    return defaultAppBar(title, []);
  }

  Widget buildCardImageItem(String displayUrl, double width, double height) {
    return new CardImageItem(displayUrl, width, height);
  }
}
