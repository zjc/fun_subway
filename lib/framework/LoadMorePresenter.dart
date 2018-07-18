import 'package:fun_subway/framework/BaseModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMoreView.dart';

abstract class LoadMorePresenter<VIEW extends LoadMoreView,
    MODEL extends BaseModel> extends BasePresenter<VIEW, MODEL> {
  void loadMore();
}
