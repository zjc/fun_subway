import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMoreView.dart';
import 'BaseState.dart';

abstract class LoadMoreState<PRESENTER extends BasePresenter,
STATEFUL_WIDGET extends StatefulWidget>
    extends BaseState<PRESENTER, STATEFUL_WIDGET>
    implements LoadMoreView {


  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  @override
  void initState() {
    super.initState();
    scaffoldKey = new GlobalKey<ScaffoldState>();
    refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  }

  Future<Null> handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 3), () {
      completer.complete(null);
    });
    return completer.future.then((_) {
      scaffoldKey.currentState?.showSnackBar(new SnackBar(
          content: const Text('Refresh complete'),
          action: new SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                refreshIndicatorKey.currentState.show();
              }
          )
      ));
    });
  }

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