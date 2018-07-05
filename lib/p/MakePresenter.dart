import 'package:fun_subway/view/MakeView.dart';
import 'package:fun_subway/model/MakeModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class MakePresenter extends BasePresenter<MakeView, MakeModel> {
  @override
  MakeModel newInstance() {
    return new MakeModel();
  }
}
