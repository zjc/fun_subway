import 'package:fun_subway/business/FunAuth.dart';
import 'package:fun_subway/business/model/SettingModel.dart';
import 'package:fun_subway/business/view/SettingView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class SettingPresenter extends BasePresenter<SettingView, SettingModel> {
  @override
  SettingModel newInstance() {
    return new SettingModel();
  }

  void loginOut() {
    FunAuth().logout();
  }

  List<SettingMenu> getSettingMenus() {
    List<SettingMenu> settingMenus = [];
    settingMenus.add(new SettingMenu(0, SettingMenu.ITEM_TYPE_NORMAL, "账户管理"));
    settingMenus.add(new SettingMenu(1, SettingMenu.ITEM_TYPE_NORMAL, "清理缓存"));
    settingMenus.add(new SettingMenu(2, SettingMenu.ITEM_TYPE_NORMAL, "用户协议"));
    settingMenus.add(new SettingMenu(3, SettingMenu.ITEM_TYPE_NORMAL, "免责申明"));
    settingMenus.add(new SettingMenu(4, SettingMenu.ITEM_TYPE_SPACE, ""));
    settingMenus.add(new SettingMenu(5, SettingMenu.ITEM_TYPE_NORMAL, "退出登录"));
    return settingMenus;
  }
}

class SettingMenu {
  static const ITEM_TYPE_NORMAL = 0;
  static const ITEM_TYPE_SPACE = 1;

  final int id; //0:账户管理，1:清理缓存 2:用户协议 3:免责申明 4.间隔  5.退出登录

  final String itemName;

  final int itemType;

  SettingMenu(this.id, this.itemType, this.itemName);
}
