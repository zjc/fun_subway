import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMoreView.dart';
import 'BaseState.dart';

abstract class LoadMoreState<PRESENTER extends BasePresenter,
        STATEFUL_WIDGET extends StatefulWidget>
    extends BaseState<PRESENTER, STATEFUL_WIDGET> implements LoadMoreView {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
  }

  Future<Null> handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 3), () {
      refreshData();
      completer.complete(null);
    });
    return completer.future.then((_) {
      //刷新完成
    });
  }

  //下拉刷新
  void refreshData();

  @override
  void disableFooter() {
    // TODO: implement disableFooter
  }

  @override
  void showLoadMore() {
    // TODO: implement showLoadMore
  }

  @override
  void showLoadMoreEmpty() {
    // TODO: implement showLoadMoreEmpty
  }

  @override
  void showLoadMoreError() {
    // TODO: implement showLoadMoreError
  }
}
