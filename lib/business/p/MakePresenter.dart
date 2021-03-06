import 'package:fun_subway/business/view/MakeView.dart';
import 'package:fun_subway/business/model/MakeModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class MakePresenter extends BasePresenter<MakeView, MakeModel> {
  @override
  MakeModel newInstance() {
    return new MakeModel();
  }

  void fetchData() {
    model.fetchMakeMenu().then((responseBean) {
      if (responseBean.isSuccess()) {
        getView()?.callback(responseBean.data);
      }
    });
  }
}
