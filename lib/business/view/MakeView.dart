import 'package:fun_subway/business/beans/MakerBean.dart';
import 'package:fun_subway/framework/BaseView.dart';

abstract class MakeView extends BaseView {
  void callback(MakerBean makeBean);
}
