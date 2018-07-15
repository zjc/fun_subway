import 'package:flutter/material.dart';
import 'package:fun_subway/business/p/SettingPresenter.dart';
import 'package:fun_subway/business/view/SettingView.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/utils/DialogAction.dart';
import 'package:fun_subway/utils/FunColors.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends BaseState<SettingPresenter, SettingPage>
    implements SettingView {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: defaultSimpleAppBar("设置"),
      body: ListView.builder(
        itemCount: mPresenter.getSettingMenus().length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: _buildItem(index),
            onTap: () {
              onItemClick(mPresenter.getSettingMenus()[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildItem(int index) {
    SettingMenu settingMenu = mPresenter.getSettingMenus()[index];
    switch (settingMenu.itemType) {
      case SettingMenu.ITEM_TYPE_NORMAL:
        return _buildItemNormal(settingMenu);
      case SettingMenu.ITEM_TYPE_SPACE:
        return buildDivider(10.0);
    }
    return buildDivider(10.0);
  }

  Widget _buildRightArrow(SettingMenu setting) {
    if (setting.id == 1) {
      return new Text("3.3M");
    } else if (setting.id == 5) {
      return new Text("");
    } else {
      return new Icon(Icons.keyboard_arrow_right);
    }
  }

  Widget _buildBottomLine(SettingMenu settingMenu) {
    if (settingMenu.id == 3) {
      //不需要padding值
      return new Divider(
        height: 0.5,
        color: FunColors.lineColor,
      );
    } else if (settingMenu.id == 5) {
      //不需要线
      return new Container();
    } else {
      return new Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: new Divider(
          height: 0.5,
          color: FunColors.lineColor,
        ),
      );
    }
  }

  void onItemClick(SettingMenu settingMenu) {
    switch (settingMenu.id) {
      case 5: //登出
        showLoginOutDialog();
        break;
    }
  }

  void showLoginOutDialog() {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);
    showDialog<DialogAction>(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
            title: const Text('退出登录'),
            content: new Text("确定登出登录？",
                style: dialogTextStyle
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.pop(context, DialogAction.cancel);
                  }
              ),
              new FlatButton(
                  child: const Text('确定'),
                  onPressed: () {
                    Navigator.pop(context, DialogAction.agree);
                  }
              )
            ]
        );
      },
    ).then<void>((DialogAction value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        switch(value){
          case DialogAction.agree:
            mPresenter.loginOut();
            Navigator.of(context).pop("loginOut");
            break;
          default:
            break;
        }
      }
    });
  }

  Widget _buildItemNormal(SettingMenu settingMenu) {
    return new Container(
      color: Colors.white,
      height: 55.0,
      child: new Column(
        children: <Widget>[
          new Expanded(
              child: new Container(
            margin: EdgeInsets.only(left: 20.0, right: 15.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  settingMenu.itemName,
                  style: new TextStyle(color: FunColors.c_333, fontSize: 16.0),
                ),
                _buildRightArrow(settingMenu),
              ],
            ),
          )),
          _buildBottomLine(settingMenu),
        ],
      ),
    );
  }

  @override
  SettingPresenter newInstance() {
    return new SettingPresenter();
  }
}
