import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/framework/LoadMoreView.dart';

abstract class ImageBeanView extends LoadMoreView {
  void updateList(List<ImageBean> images);
}
