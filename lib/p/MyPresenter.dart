import 'package:fun_subway/view/MyView.dart';
import 'package:fun_subway/model/MyModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class MyPresenter extends BasePresenter<MyView, MyModel> {
  @override
  MyModel newInstance() {
    return new MyModel();
  }
}
