import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/CommentBean.dart';
import 'package:fun_subway/business/beans/HomeBanner.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/business/router/FunRouter.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/business/p/HomePresenter.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/Pair.dart';
import 'package:fun_subway/utils/utils.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';
import 'package:fun_subway/business/view/HomeView.dart';
import 'package:fun_subway/widget/BannerEntity.dart';
import 'package:fun_subway/widget/BannerWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:fun_subway/widget/PostWidget.dart';

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
        automaticallyImplyLeading: false,
      ),
      body: _buildListWidget(),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: FunColors.themeColor,
        tooltip: "jump to publish",
        onPressed: () {
          FunRouteFactory.go2PostPublishPage(context);
        },
        child: new Icon(Icons.add),
      ),
    );
  }

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
          controller: mScrollController,
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
        PostBean postBean = pair.second;
        widget = new InkWell(
          onTap: () {
            FunRouteFactory.go2PostDetail(context, postBean.id);
          },
          child: new PostWidget(postBean, PostWidget.SOURCE_TYPE_HOME,
              deletePostCallback: deletePost),
        );
        break;
    }
    return widget;
  }

  void deletePost(PostBean postBean) {
    for (Pair pair in _datasource) {
      int itemType = pair.first;
      if (itemType == HomePresenter.ITEM_TYPE_HOME_POST) {
        PostBean tempPostBean = pair.second;
        if (postBean.id == tempPostBean.id) {
          setState(() {
            _datasource.remove(pair);
            //TODO 请求后台接口
            showToast("删除成功,下次我们会减少该内容的推荐");
          });
          return;
        }
      }
    }
  }

  void refreshData() {
    mPresenter.fetchHomeData();
  }

  Widget _buildSearchWidget() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new OutlineButton.icon(
          onPressed: () {
            FunRouteFactory.go2SearchPage(context, null);
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
    mPresenter.fetchHomeData();
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
                    FunRouteFactory.go2MyTopicPage(context);
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
                      FunRouteFactory.go2TopicDetailPage(context, topicBean.name);
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
          //滚动到顶部
          scrollToTop();
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
                  String hot = hotTags[index];
                  return new InkWell(
                    onTap: () {
                      FunRouteFactory.go2SearchPage(context, hot);
                    },
                    child: new Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: new Text(
                        hot,
                        style: new TextStyle(
                            color: Colors.black54, fontSize: 14.0),
                      ),
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
    return new BannerWidget(
      entities: entities,
      bannerPress: bannerClick,
    );
  }

  void bannerClick(int position, BannerEntity entity) {
    FunRouter.navigate(context, entity.bannerAction);
  }

  @override
  void callback(List<Pair> pairs) {
    setState(() {
      this._datasource = pairs;
    });
  }
}
