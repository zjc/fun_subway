import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/LoginBean.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/business/p/MyPresenter.dart';
import 'package:fun_subway/business/view/MyView.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends BaseState<MyPresenter, MyPage> implements MyView {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: kMaterialListPadding,
      itemCount: mPresenter.getMenus().length,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: _buildItem,
    );
  }

  Widget _buildLoginWidget() {
    LoginBean loginBean = mPresenter.getLoginBean();
    var countTextStyle = new TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: FunColors.c_333);
    var widget = new Row(
      children: <Widget>[
        new InkWell(
          onTap: () {
            //TODO 点击头像去个人动态界面
          },
          child: new ClipOval(
            child: new FadeInImage.assetNetwork(
              image: '${loginBean.user.profilePicture}',
              width: 81.0,
              height: 81.0,
              placeholder: "images/ic_default_head.png",
            ),
          ),
        ),
        new Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text('${loginBean.user.nickname}'),
                  new Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: new Image.asset(
                      '${loginBean.user.sex == 1
                          ? "images/ic_mine_male.png"
                          : "images/ic_mine_female.png"}',
                      width: 17.0,
                      height: 17.0,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new InkWell(
                    onTap: () {
                      //TODO go2 关注
                    },
                    child: new Column(
                      children: <Widget>[
                        new Text("关注"),
                        new Text(
                          '${loginBean.user.followCount}',
                          style: countTextStyle,
                        )
                      ],
                    ),
                  ),
                  new Text("|"),
                  new InkWell(
                    onTap: () {
                      //TODO go2 fans
                    },
                    child: new Column(
                      children: <Widget>[
                        new Text("粉丝"),
                        new Text(
                          '${loginBean.user.fansCount}',
                          style: countTextStyle,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );

    return _buildHeaderWidget(widget);
  }

  Widget _buildHeaderWidget(Widget widget) {
    return new Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: AssetImage("images/bg_user_center.png"))),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(right: 15.0, top: 30.0),
                child: new Image.asset(
                  "images/ic_setting.png",
                  width: 22.0,
                  height: 22.0,
                ),
              )
            ],
          ),
          new Padding(
            padding: EdgeInsets.all(30.0),
            child: widget,
          ),
        ],
      ),
    );
  }

  Widget _buildUnLoginWidget() {
    var widget = new InkWell(
      onTap: () {
        FunRouteFactory.go2LoginPage(context);
      },
      child: new Row(
        children: <Widget>[
          new ClipOval(
            child: new Image.asset(
              "images/ic_default_head.png",
              width: 81.0,
              height: 81.0,
              fit: BoxFit.cover,
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new Text(
              "登录",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.black87),
            ),
          )
        ],
      ),
    );

    return _buildHeaderWidget(widget);
  }

  Widget _buildFunctionWidget() {
    return new Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0,top: 10.0,bottom: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildSingleFunctionItem(0, "ic_my_works", "作品"),
          _buildSingleFunctionItem(1, "ic_my_message", "消息"),
          _buildSingleFunctionItem(2, "ic_my_collection", "收藏"),
          _buildSingleFunctionItem(3, "ic_mine_topic", "话题"),
        ],
      ),
    );
  }

  Widget _buildSingleFunctionItem(int index, String imageName, String name) {
    return new InkWell(
      onTap: () {},
      child: new Column(
        children: <Widget>[
          new Image.asset(
            "images/" + imageName + ".png",
            width: 22.0,
            height: 22.0,
          ),
          new Text(
            name,
            style: new TextStyle(color: FunColors.c_333, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildSpace() {
    return new Container(
      height: 10.0,
      color: new Color(0xfff4f4f4),
    );
  }

  Widget _buildCommonItem(String imageName, String name) {
    return new Container(
        height: 48.0,
        child: new Column(
          children: <Widget>[
            new Container(
              height: 47.0,
              padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Image.asset(
                        "images/" + imageName + ".png",
                        width: 18.0,
                        height: 18.0,
                        fit: BoxFit.contain,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: new Text(
                          name,
                          style: new TextStyle(
                              color: FunColors.c_333, fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  new Image.asset(
                    "images/ic_right_arrow.png",
                    width: 7.0,
                    height: 12.0,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(left: 48.0),
              child: new Divider(
                height: 1.0,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }

  Widget _buildItem(BuildContext context, int index) {
    Menu menu = mPresenter.getMenus()[index];
    switch (menu.type) {
      case Menu.ITEM_TYPE_LOGIN:
        return _buildLoginWidget();
      case Menu.ITEM_TYPE_UN_LOGIN:
        return _buildUnLoginWidget();
      case Menu.ITEM_TYPE_FUNCTION:
        return _buildFunctionWidget();
      case Menu.ITEM_TYPE_SPACE:
        return _buildSpace();
      case Menu.ITEM_TYPE_FEEDBACK:
        return _buildCommonItem("ic_mine_feedback", "意见反馈");
      case Menu.ITEM_TYPE_SHARE:
        return _buildCommonItem("ic_mine_share", "分享app");
      case Menu.ITEM_TYPE_CHECK_UPDATE:
        return _buildCommonItem("ic_mine_update", "检查更新");
      case Menu.ITEM_TYPE_ABOUT:
        return _buildCommonItem("ic_mine_about", "关于");
    }
    return _buildSpace();
  }

  @override
  MyPresenter newInstance() {
    return MyPresenter();
  }
}
