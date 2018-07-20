import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/framework/BaseView.dart';

abstract class PostView extends BaseView{
  void likeSuccess(PostBean postBean);
  void likeFail();

  void unlikeSuccess(PostBean postBean);

  void unlikeFail();
}