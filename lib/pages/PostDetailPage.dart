import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/CommentBean.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/p/PostDetailPresenter.dart';
import 'package:fun_subway/business/view/PostDetailView.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';
import 'package:fun_subway/utils/Pair.dart';
import 'package:fun_subway/utils/utils.dart';
import 'package:fun_subway/widget/CommentImageWidget.dart';
import 'package:fun_subway/widget/CommentLikeWidget.dart';
import 'package:fun_subway/widget/PostWidget.dart';

class PostDetailPage extends StatefulWidget {
  int postId;

  PostDetailPage(this.postId);

  @override
  State<StatefulWidget> createState() {
    return new PostDetailState();
  }
}

class PostDetailState extends LoadMoreState<PostDetailPresenter, PostDetailPage>
    implements PostDetailView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultSimpleAppBar("详情"),
      body: _buildBody(),
    );
  }

  @override
  void initState() {
    super.initState();
    mPresenter.fetchPost(widget.postId);
    mTextEditingController = new TextEditingController();
  }

  TextEditingController mTextEditingController;

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Expanded(flex: 1, child: _buildContentWidget()),
        new Divider(
          height: 1.0,
          color: FunColors.lineColor,
        ),
        _buildInputWidget(),
      ],
    );
  }

  List<Pair> _dataSources = [];

  Widget _buildContentWidget() {
    if (_dataSources == null || _dataSources.isEmpty) {
      return showLoading();
    }
    return ListView.builder(
        padding: kMaterialListPadding,
        physics: AlwaysScrollableScrollPhysics(),
        controller: mScrollController,
        itemCount: _dataSources.length,
        itemBuilder: _buildItem);
  }

  Widget _buildItem(BuildContext context, int index) {
    Pair pair = _dataSources[index];
    int itemType = pair.first;
    switch (itemType) {
      case PostDetailPresenter.ITEM_TYPE_POST:
        PostBean postBean = pair.second;
        return new PostWidget(postBean, PostWidget.SOURCE_TYPE_POST);
      case PostDetailPresenter.ITEM_TYPE_DIVIDER:
        return buildDivider(10.0);
      case PostDetailPresenter.ITEM_TYPE_COMMENT_LABEL:
        return new Padding(
          padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
          child: new Text("全部评论"),
        );
      case PostDetailPresenter.ITEM_TYPE_COMMENT:
        CommentBean commentBean = pair.second;
        return _buildCommentWidget(commentBean);
      case PostDetailPresenter.ITEM_TYPE_COMMENT_EMPTY:
        return new Text("评论为空显示");
      default:
        return new Text("评论为空显示");
    }
  }

  Widget _buildCommentWidget(CommentBean commentBean) {
    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ClipOval(
            child: new FadeInImage.assetNetwork(
              image: '${commentBean.profilePicture}',
              width: 32.0,
              height: 32.0,
              placeholder: "images/ic_default_head.png",
            ),
          ),
          new Expanded(
              child: new Container(
            margin: EdgeInsets.only(left: 15.0),
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      commentBean.nickname,
                      style:
                          new TextStyle(color: FunColors.c_666, fontSize: 15.0),
                    ),
                    new InkWell(
                      onTap: () {
                        //TODO 点击评论的爱心
                      },
                      child: new CommentLikeWidget(
                          commentBean.likeCount, commentBean.likeStatus),
                    )
                  ],
                ),
                new Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: new Text(
                    TextUtils.isEmpty(commentBean.content)
                        ? "分享图片"
                        : commentBean.content,
                    style:
                        new TextStyle(color: FunColors.c_333, fontSize: 16.0),
                  ),
                ),
                new CommentImageWidget(
                  commentBean,
                  50,
                  isNetworkAvailable: isNetworkAvailable,
                  isWifi: isWifi,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildInputWidget() {
    return new Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
      child: new Row(
        children: <Widget>[
          new InkWell(
            onTap: () {
              showToast("go2 select picture gallery....");
            },
            child: new Image.asset(
              "images/ic_post_detail_comment.png",
              width: 24.0,
              height: 24.0,
              fit: BoxFit.contain,
            ),
          ),
          new Flexible(
            child: new Container(
              height: 34.0,
              margin: EdgeInsets.only(left: 15.0),
              decoration: new BoxDecoration(
                  color: new Color(0xfff7f7f7),
                  borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                  border: new Border.all(color: Colors.grey, width: 0.5)),
              child: new TextField(
                  controller: mTextEditingController,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 10.0, top: 4.0, right: 10.0),
                    hintText: "请开始你的表演",
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PostDetailPresenter newInstance() {
    return new PostDetailPresenter();
  }

  @override
  void fetchCallback(List<Pair> pairs) {
    setState(() {
      _dataSources = pairs;
    });
  }
}
