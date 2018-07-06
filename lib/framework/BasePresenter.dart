import 'BaseView.dart';
import 'BaseModel.dart';

abstract class BasePresenter<VIEW extends BaseView, MODEL extends BaseModel> {
  VIEW referenceView;

  MODEL model;

  BasePresenter() {
    model = newInstance();
  }

  //将view层的接口和Presenter进行绑定
  void bindView(VIEW view) {
    referenceView = view;
  }

  //将视图层接口引用进行解绑
  void unbindView() {
    referenceView = null;
  }

  //返回view层的接口实现,用于回调
  VIEW getView() {
    return referenceView;
  }

  //返回具体的model去处理数据请求
  MODEL getModel() {
    return model;
  }

  void showSnackbar(String desc, String buttonName, String action) {
    if (getView() != null) {
      getView().showSnackbar(desc, buttonName, action);
    }
  }

  void showSimpleSnackbar(String desc) {
    showSnackbar(desc, null, null);
  }

  //销毁P层
  void onDestroy() {
    unbindView();
    unbindModel();
  }

  void unbindModel() {
    model = null;
  }

//由每个具体的Presenter去创建MODEL
  MODEL newInstance();
}
