import 'package:fun_subway/business/beans/LoginBean.dart';
import 'package:fun_subway/business/view/MyView.dart';
import 'package:fun_subway/business/model/MyModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class MyPresenter extends BasePresenter<MyView, MyModel> {
  @override
  MyModel newInstance() {
    return new MyModel();
  }

  List<Menu> getMenus() {
    List<Menu> menus = [];
    if (model.isLogin()) {
      menus.add(new Menu(Menu.ITEM_TYPE_LOGIN));
    } else {
      menus.add(new Menu(Menu.ITEM_TYPE_UN_LOGIN));
    }
    menus.add(new Menu(Menu.ITEM_TYPE_FUNCTION));
    menus.add(new Menu(Menu.ITEM_TYPE_SPACE));
    menus.add(new Menu(Menu.ITEM_TYPE_FEEDBACK));
    menus.add(new Menu(Menu.ITEM_TYPE_SHARE));
    menus.add(new Menu(Menu.ITEM_TYPE_CHECK_UPDATE));
    menus.add(new Menu(Menu.ITEM_TYPE_ABOUT));
    return menus;
  }

  void setLoginBean(LoginBean loginBean) {
    model.setLoginBean(loginBean);
  }

  LoginBean getLoginBean() {
    return model.getLoginBean();
  }
}

class Menu {
  static const ITEM_TYPE_LOGIN = 1;
  static const ITEM_TYPE_UN_LOGIN = 2;
  static const ITEM_TYPE_FUNCTION = 3;
  static const ITEM_TYPE_SPACE = 4;
  static const ITEM_TYPE_FEEDBACK = 5;
  static const ITEM_TYPE_SHARE = 6;
  static const ITEM_TYPE_CHECK_UPDATE = 7;
  static const ITEM_TYPE_ABOUT = 8;

  final int type;

  Menu(this.type);
}
