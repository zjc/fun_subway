import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/p/PostPublishPresenter.dart';
import 'package:fun_subway/business/view/PostPublishView.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/utils.dart';

class PostPublishPage extends StatefulWidget {
  String topicName; //话题名称

  ImageBean imageBean; //制作好的图片，发表

  PostPublishPage({this.topicName, this.imageBean});

  @override
  State<StatefulWidget> createState() {
    return new PostPublishState();
  }
}

class PostPublishState extends BaseState<PostPublishPresenter, PostPublishPage>
    implements PostPublishView {
  bool isComplete = false;

  String inputText;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: defaultAppBar("发布", [
        new Container(
          padding: EdgeInsets.fromLTRB(15.0, 12.0, 10.0, 12.0),
          height: 30.0,
          child: new RaisedButton(
            elevation: 0.0,
            highlightColor: FunColors.themeColor,
            onPressed: () {
              //TODO 调用发布接口
            },
            color: isComplete ? FunColors.themeColor : FunColors.c_eee,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: new Text(
              "发布",
              style: new TextStyle(color: Colors.white),
            ),
          ),
        )
      ]),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new SingleChildScrollView(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) {
                      isComplete = false;
                      inputText = val;
                      print("======>onChanged:" + val);
                    },
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      hintText: "分享有趣的表情~",
                    )),
                new Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new Card(
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    ),
                    child: new Container(
                      padding: EdgeInsets.all(20.0),
                      alignment: Alignment.centerLeft,
                      width: 100.0,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            "images/ic_publish_image_selector.png",
                            width: 30.0,
                            height: 30.0,
                            fit: BoxFit.contain,
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: new Text(
                              "添加表情",
                              style: new TextStyle(
                                  color: FunColors.c_333, fontSize: 14.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        new Divider(
          height: 0.5,
          color: FunColors.lineColor,
        ),
        new Container(
          padding:
              EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0, top: 10.0),
          child: new Row(
            children: <Widget>[
              new InkWell(
                onTap: () {},
                child: new Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: new Image.asset(
                    "images/ic_publish_topic.png",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new InkWell(
                onTap: () {},
                child: new Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: new Image.asset(
                    "images/ic_publish_show.png",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  PostPublishPresenter newInstance() {
    return new PostPublishPresenter();
  }
}
