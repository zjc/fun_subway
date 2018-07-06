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
  void showLoading() {
    
  }

  @override
  void showSnackbar(String desc,String buttonName,String action){

  }
}
