import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/HomeBanner.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/business/p/HomePresenter.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/Pair.dart';
import 'package:fun_subway/utils/utils.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';
import 'package:fun_subway/business/view/HomeView.dart';
import 'package:fun_subway/widget/BannerWidget.dart';
import 'package:flutter/gestures.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends LoadMoreState<HomePresenter, HomePage>
    implements HomeView {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: _buildSearchWidget(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _buildListWidget(),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: FunColors.themeColor,
        tooltip: "jump to publish",
        onPressed: () {
          showSimpleSnackbar("跳转发布界面");
        },
        child: new Icon(Icons.add),
      ),
    );
  }

  ScrollController _scrollController;
  bool _isShowRetry = false;

  List<Pair> _datasource = [];

  Widget _buildListWidget() {
    var widget;
    if (null == _datasource || _datasource.isEmpty) {
      if (_isShowRetry) {
        _isShowRetry = false;
        widget = buildRetry("网络错误", refreshData);
      } else {
        widget = showLoading();
      }
    } else {
      widget = new RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: handleRefresh,
        child: new ListView.builder(
          padding: kMaterialListPadding,
          controller: _scrollController,
          itemCount: _datasource.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: _buildItem,
        ),
      );
    }
    return widget;
  }

  @override
  Widget showError() {
    setState(() {
      _isShowRetry = true;
    });
    return null;
  }

  Widget _buildItem(BuildContext context, int index) {
    final pair = _datasource[index];
    Widget widget;
    int itemType = pair.first;
    switch (itemType) {
      case HomePresenter.ITEM_TYPE_HOME_BANNER: //banner
        widget = _buildBannerWidget(pair);
        break;
      case HomePresenter.ITEM_TYPE_HOME_HOT_TAGS:
        widget = _buildHotTagsWidget(pair);
        break;
      case HomePresenter.ITEM_TYPE_HOME_TOPIC:
        widget = _buildTopicWidget(pair);
        break;
      case HomePresenter.ITEM_TYPE_HOME_LAST_VIEWED:
        widget = _buildLastViewed(pair);
        break;
      case HomePresenter.ITEM_TYPE_HOME_POST:
        widget = _buildPostWidget(pair);
        break;
    }
    return widget;
  }

  void refreshData() {
    print("refreshData-------------------------------------------------------------->>>>>");
    mPresenter.fetchHomeData();
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
          new Image.asset(
            "images/ic_usercenter_delete_the_post.png",
            width: 22.0,
            height: 16.0,
            fit: BoxFit.cover,
          )
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
              new Row(
                children: <Widget>[
                  new Text(
                    '${commentBean.likeCount}',
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: new Color(0xff999999),
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: new Image.asset(
                      '${
                          commentBean.likeStatus
                              ? "images/ic_home_like2.png"
                              : "images/ic_home_unlike2.png"
                      }',
                      width: 14.0,
                      height: 12.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
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
          new GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            primary: true,
            physics: ScrollPhysics(),
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            children: commentBean.commentImgs.map((ImageBean imageBean) {
              String displayUrl = ImageBean.getDisplayUrl(
                  isNetworkAvailable, isWifi, imageBean);
              double itemWidth = (MediaQuery.of(context).size.width - 60) / 3;
              return new InkWell(
                onTap: () {
                  FunRouteFactory.go2ImagePreview(
                      context, imageBean, commentBean.commentImgs);
                },
                child: _buildCardImageItem(displayUrl, itemWidth, itemWidth),
              );
            }).toList(),
          )
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
          new Row(
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

  Widget _buildCardImageItem(String displayUrl, double width, double height) {
    return new Card(
      shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0))),
      child: new Image.network(
        displayUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }

  bool isNetworkAvailable = true;
  bool isWifi = true;

  Widget _buildPostImage(PostBean postBean) {
    List<Widget> widgets = []; //表情控件

    List<ImageBean> postImages =
        postBean.show ? postBean.showImgs : postBean.memeImgs;
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
            Size size = PostBean.getDisplaySize(context, postImages.length, imagebean);
            String displayUrl =
                ImageBean.getDisplayUrl(isNetworkAvailable, isWifi, imagebean);
            return new InkWell(
              onTap: () {
                FunRouteFactory.go2ImagePreview(context, imagebean, postImages);
              },
              child: _buildCardImageItem(displayUrl, size.width, size.height),
            );
          }).toList(),
        )));

    //添加表情包
    if (postBean.show &&
        postBean.memeImgs != null &&
        postBean.memeImgs.isNotEmpty) {
      widgets.add(new Container(
        height: 70.0,
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
              child: _buildCardImageItem(displayUrl, 65.0, 65.0),
            );
          },
        ),
      ));
    }

    return new Column(
      children: widgets,
    );
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

  Widget _buildPostWidget(Pair pair) {
    PostBean postBean = pair.second;
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          //分割线
          buildDivider(10.0),
          new Container(
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
          ),
        ],
      ),
    );
  }

  Widget _buildSearchWidget() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
            child: new OutlineButton.icon(
          onPressed: () {
            //TODO 跳转到search界面
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          borderSide: new BorderSide(color: Colors.grey),
          icon: new Icon(Icons.search),
          label: new Text("搜索你想要的表情"),
        )),
      ],
    );
  }

  @override
  initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(_scrollListener);
    mPresenter.fetchHomeData();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      mPresenter.loadMore();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  @override
  HomePresenter newInstance() {
    return HomePresenter();
  }

  Widget _buildTopicWidget(Pair pair) {
    List<TopicBean> topicBeans = pair.second;
    return new Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Column(
        children: <Widget>[
          new Container(
            height: 40.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("热聊话题"),
                new InkWell(
                  onTap: () {
                    //TODO 关注的话题
                    showSimpleSnackbar("关注的话题");
                  },
                  child: new Row(
                    children: <Widget>[
                      new Text("关注的话题"),
                      new Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        child: new Image.asset(
                          "images/ic_right_arrow.png",
                          width: 10.0,
                          height: 10.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            height: 85.0,
            child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topicBeans.length,
                itemBuilder: (context, index) {
                  var topicBean = topicBeans[index];
                  String name = "#" + topicBean.name;
                  return new InkWell(
                    onTap: () {
                      showSimpleSnackbar("点击话题<" + name + ">");
                    },
                    child: new Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Stack(
                        children: <Widget>[
                          new Image.network(
                            '${topicBean.background}',
                            width: 140.0,
                            height: 85.0,
                            fit: BoxFit.cover,
                          ),
                          new Container(
                            width: 140.0,
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  '${name}',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                                new Text(
                                  '${topicBean.intro}',
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildLastViewed(Pair pair) {
    return new Container(
      height: 45.0,
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.center,
      child: new InkWell(
        onTap: () {
          refreshData();
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("上次看到这里，点击刷新"),
            new Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Image.asset(
                "images/ic_rotate.png",
                width: 15.0,
                height: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotTagsWidget(Pair pair) {
    List<String> hotTags = pair.second;
    return new Container(
      height: 60.0,
      padding: EdgeInsets.only(left: 12.0, right: 12.0),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            "images/ic_hot_tag.png",
            width: 47.0,
            height: 37.0,
            fit: BoxFit.cover,
          ),
          new Expanded(
            child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hotTags.length,
                itemBuilder: (context, index) {
                  return new Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: new Text(
                      '${hotTags[index]}',
                      style:
                          new TextStyle(color: Colors.black54, fontSize: 14.0),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildBannerWidget(Pair pair) {
    List<HomeBanner> entities = pair.second;
    return new BannerWidget(entities: entities);
  }

  @override
  void callback(List<Pair> pairs) {
    setState(() {
      this._datasource = pairs;
    });
  }
}
