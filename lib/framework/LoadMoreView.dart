import 'package:fun_subway/framework/BaseView.dart';

abstract class LoadMoreView implements BaseView{
  void showLoadMoreEmpty();

  void showLoadMore();

  void showLoadMoreError();

  void disableFooter();
}