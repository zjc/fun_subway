import 'package:fun_subway/view/HomeView.dart';
import 'package:fun_subway/model/HomeModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class HomePresenter extends BasePresenter<HomeView, HomeModel> {
  @override
  HomeModel newInstance() {
    return new HomeModel();
  }
}
