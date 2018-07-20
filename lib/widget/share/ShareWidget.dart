import 'package:flutter/material.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/widget/share/ShareData.dart';
import 'package:fun_subway/widget/share/SharePlatform.dart';

class ShareWidget extends StatefulWidget {
  List<ShareData> _shareDatas;

  ShareWidget(this._shareDatas);

  @override
  State<StatefulWidget> createState() {
    return new ShareState();
  }
}

class ShareState extends State<ShareWidget> {
  List<SharePlatform> _platforms = [];

  @override
  void initState() {
    super.initState();
    _platforms = SharePlatformFactory.defaultSharePlatformFactory(); //初始化要分享的平台
    SharePlatformFactory.bindShareDatas(_platforms, widget._shareDatas);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 120.0,
        child: new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _platforms.length,
      itemBuilder: (context, index) {
        SharePlatform platform = _platforms[index];
        return new InkWell(
          onTap: () {
            print("TODO 调用平台中的分享功能!"+platform.platform);
          },
          child: new Container(
            margin: EdgeInsets.only(left: 10.0,right: 10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  platform.res,
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.contain,
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new Text(
                    platform.platform,
                    style:
                        new TextStyle(fontSize: 16.0, color: FunColors.c_333),
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
