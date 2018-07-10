import 'package:flutter/material.dart';
import 'BaseView.dart';
import 'BasePresenter.dart';

abstract class BaseState<PRESENTER extends BasePresenter,
        STATEFUL_WIDGET extends StatefulWidget> extends State<STATEFUL_WIDGET>
    implements BaseView {
  PRESENTER mPresenter;

  @override
  void initState() {
    super.initState();
    mPresenter = newInstance();
    mPresenter.bindView(this);
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

  @override
  void showSnackbar(String desc, String buttonName, String action) {
    var snackBar = new SnackBar(content: new Text(desc));
    if (buttonName != null && buttonName.isNotEmpty) {
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
        children: <Widget>[
          new Image.asset(
            "images/ic_nonetwork.png",
            width: 183.0,
            height: 140.0,
            fit: BoxFit.cover,
          ),
          new Text(error,
              style: new TextStyle(color: Colors.black87, fontSize: 14.0)),
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
}
