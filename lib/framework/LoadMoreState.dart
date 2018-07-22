import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMorePresenter.dart';
import 'package:fun_subway/framework/LoadMoreView.dart';
import 'BaseState.dart';

abstract class LoadMoreState<PRESENTER extends LoadMorePresenter,
        STATEFUL_WIDGET extends StatefulWidget>
    extends BaseState<PRESENTER, STATEFUL_WIDGET> implements LoadMoreView {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController mScrollController;

  @override
  void initState() {
    super.initState();
    mScrollController = new ScrollController()..addListener(scrollListener);
  }

  void scrollListener() {
    if (mScrollController.position.pixels ==
        mScrollController.position.maxScrollExtent) {
      mPresenter.loadMore();
    }
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

  @override
  void dispose() {
    super.dispose();
    mScrollController.removeListener(scrollListener);
    mScrollController = null;
  }

  //下拉刷新,子类有可能需要
  void refreshData() {}


  void scrollToTop() {
    mScrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
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
