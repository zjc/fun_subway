import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/CommentBean.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/p/PostPresenter.dart';
import 'package:fun_subway/business/view/PostView.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';
import 'package:fun_subway/widget/CommentImageWidget.dart';
import 'package:fun_subway/widget/CommentLikeWidget.dart';

typedef void DeletePostCallback(PostBean postBean);

class PostWidget extends StatefulWidget {
  static const SOURCE_TYPE_HOME = 0;
  static const SOURCE_TYPE_POST = 1;
  static const SOURCE_TYPE_POST_USER = 2;

  PostBean postBean;

  int sourceType; //标记来源 0:首页 1:动态详情 2: 个人动态 3:话题里面的动态

  DeletePostCallback deletePostCallback;

  PostWidget(this.postBean, this.sourceType, {this.deletePostCallback});

  @override
  State<StatefulWidget> createState() {
    return new PostState();
  }
}

class PostState extends BaseState<PostPresenter, PostWidget>
    implements PostView {
  @override
  Widget build(BuildContext context) {
    switch (widget.sourceType) {
      case PostWidget.SOURCE_TYPE_HOME:
        return _buildHomePostWrapperWidget(widget.postBean);
      default:
        return _buildPostWidget(widget.postBean);
    }
  }

  Widget _buildPostWidget(PostBean postBean) {
    return new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Column(
        children: <Widget>[
          //头部容器
          _buildPostAvatar(postBean),
          //帖子文本
          _buildPostText(postBean),
          //图片展示
          _buildPostImage(postBean),
          //分享
          _buildFunctionBar(postBean),
          //评论widget
          _buildCommentWidget(postBean),
        ],
      ),
    );
  }

  Widget _buildCommentWidget(PostBean postBean) {
    if (postBean.great == null) {
      //没有神评论
      return new Container();
    }
    var commentBean = postBean.great;

    return new Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
          color: new Color(0xfff7f7f7),
          borderRadius: new BorderRadius.all(new Radius.circular(3.0)),
          border: new Border.all(color: Colors.grey, width: 0.5)),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Image.asset(
                    "images/ic_awesome_comment.png",
                    width: 32.0,
                    height: 21.0,
                    fit: BoxFit.cover,
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: new Text(
                      '${commentBean.nickname}',
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: new Color(0xff999999),
                      ),
                    ),
                  )
                ],
              ),
              new CommentLikeWidget(
                  commentBean.likeCount, commentBean.likeStatus),
            ],
          ),
          new Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 10.0),
            child: new Text(
              '${commentBean.content}',
              style: new TextStyle(
                fontSize: 16.0,
                color: new Color(0xff666666),
              ),
            ),
          ),
          new CommentImageWidget(
            commentBean,
            60,
            isNetworkAvailable: isNetworkAvailable,
            isWifi: isWifi,
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionBar(PostBean postBean) {
    return new Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new InkWell(
            onTap: () {
              showShareBottomSheet(context);
            },
            child: new Row(
              children: <Widget>[
                new Image.asset(
                  "images/ic_home_share.png",
                  width: 19.0,
                  height: 17.0,
                  fit: BoxFit.cover,
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: new Text(
                    "分享",
                    style: new TextStyle(color: Color(0xff666666)),
                  ),
                ),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              new Image.asset(
                "images/ic_home_comment.png",
                width: 19.0,
                height: 17.0,
                fit: BoxFit.cover,
              ),
              new Padding(
                padding: EdgeInsets.only(left: 6.0),
                child: new Text(
                  '${postBean.commentCount}',
                  style:
                      new TextStyle(color: Color(0xff666666), fontSize: 14.0),
                ),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              new Image.asset(
                '${postBean.like
                    ? "images/ic_home_like.png"
                    : "images/ic_home_unlike.png"}',
                width: 19.0,
                height: 17.0,
                fit: BoxFit.cover,
              ),
              new Padding(
                padding: EdgeInsets.only(left: 6.0),
                child: new Text(
                  '${postBean.likeCount}',
                  style:
                      new TextStyle(color: Color(0xff666666), fontSize: 14.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHomePostWrapperWidget(PostBean postBean) {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          //分割线
          buildDivider(10.0),
          _buildPostWidget(postBean),
        ],
      ),
    );
  }

  Widget _buildPostImage(PostBean postBean) {
    List<Widget> widgets = []; //表情控件

    List<ImageBean> postImages = (postBean.show != null && postBean.show)
        ? postBean.showImgs
        : postBean.memeImgs;
    int count = PostBean.getColumnCount(postImages.length);
    widgets.add(new Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: new GridView.count(
          shrinkWrap: true,
          primary: true,
          crossAxisCount: count,
          physics: ScrollPhysics(),
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          children: postImages.map((ImageBean imagebean) {
            Size size =
                PostBean.getDisplaySize(context, postImages.length, imagebean);
            String displayUrl =
                ImageBean.getDisplayUrl(isNetworkAvailable, isWifi, imagebean);
            return new InkWell(
              onTap: () {
                FunRouteFactory.go2ImagePreview(context, imagebean, postImages);
              },
              child: buildCardImageItem(displayUrl, size.width, size.height),
            );
          }).toList(),
        )));

    //添加表情包
    if (postBean.show != null &&
        postBean.show &&
        postBean.memeImgs != null &&
        postBean.memeImgs.isNotEmpty) {
      widgets.add(new Container(
        height: 80.0,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(bottom: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          primary: true,
          scrollDirection: Axis.horizontal,
          itemCount: postBean.memeImgs.length,
          itemBuilder: (context, index) {
            ImageBean imageBean = postBean.memeImgs[index];
            String displayUrl =
                ImageBean.getDisplayUrl(isNetworkAvailable, isWifi, imageBean);
            return new InkWell(
              onTap: () {
                FunRouteFactory.go2ImagePreview(
                    context, imageBean, postBean.memeImgs);
              },
              child: buildCardImageItem(displayUrl, 65.0, 65.0),
            );
          },
        ),
      ));
    }

    return new Column(
      children: widgets,
    );
  }

  Widget _buildPostAvatar(PostBean postBean) {
    return new Container(
      height: 52.0,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new ClipOval(
                child: new FadeInImage.assetNetwork(
                  image: '${postBean.profilePicture}',
                  width: 32.0,
                  height: 32.0,
                  placeholder: "images/ic_default_head.png",
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: new Text('${postBean.nickname}'),
              )
            ],
          ),
          _buildPostAvatarRight(postBean),
        ],
      ),
    );
  }

  Widget _buildPostAvatarRight(PostBean postBean) {
    if (widget.sourceType == PostWidget.SOURCE_TYPE_HOME) {
      return new InkWell(
        onTap: () {
          if (widget.deletePostCallback != null) {
            widget.deletePostCallback(postBean);
          }
        },
        child: new Image.asset(
          "images/ic_usercenter_delete_the_post.png",
          width: 22.0,
          height: 16.0,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return new RaisedButton(
        highlightColor: FunColors.themeColor,
        onPressed: () {},
        color: FunColors.themeColor,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
        child: new Text(
          "关注",
          style: new TextStyle(color: Colors.white),
        ),
      );
    }
  }

  Widget _buildPostText(PostBean postBean) {
    if (TextUtils.isEmpty(postBean.content)) {
      postBean.content = "分享图片";
    }

    if (postBean.great != null) {
      if (TextUtils.isEmpty(postBean.great.content)) {
        postBean.great.content = "分享图片";
      }
    }

    String topicName = "";
    if (!TextUtils.isEmpty(postBean.topicNames) && postBean.topic) {
      topicName = "#" + postBean.topicNames + "#";

      final TapGestureRecognizer recognizer = new TapGestureRecognizer();
      recognizer.onTap = () {
        //TODO 跳转话题界面
        Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('话题被点击!'),
            ));
      };

      return new Container(
        alignment: Alignment.centerLeft,
        child: new RichText(
          text: new TextSpan(
            text: topicName,
            style: new TextStyle(color: FunColors.themeColor),
            recognizer: recognizer,
            children: [
              new TextSpan(
                  text: postBean.content,
                  style: new TextStyle(color: Colors.black87))
            ],
          ),
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      return new Container(
        //必须要用container包一下，否则不左对齐
        alignment: Alignment.centerLeft,
        child: new Text(
          postBean.content,
          style: new TextStyle(color: Colors.black87),
        ),
      );
    }
  }

  @override
  PostPresenter newInstance() {
    return new PostPresenter();
  }
}
