import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/business/p/TopicDetailPresenter.dart';
import 'package:fun_subway/business/view/TopicDetailView.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/pages/TopicDetailChildPage.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/utils.dart';
import 'package:fun_subway/widget/CustomFlexibleSpaceBar.dart';

class TopicDetailPage extends StatefulWidget {
  String topicName;

  TopicDetailPage(this.topicName);

  @override
  State<StatefulWidget> createState() {
    return TopicDetailState();
  }
}

class TopicDetailState
    extends LoadMoreState<TopicDetailPresenter, TopicDetailPage>
    with SingleTickerProviderStateMixin
    implements TopicDetailView {
  double _appBarHeight = 174.0;

  TopicBean _topicBean;

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    mPresenter.fetchTopicDetail(widget.topicName);
    _tabController = new TabController(initialIndex: 0, length: 2, vsync: this);
  }

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeight,
              floating: false,
              pinned: true,
              backgroundColor: FunColors.c_333,
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.share),
                  tooltip: "分享话题",
                  onPressed: () {
                    showShareBottomSheet(context);
                  },
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.topicName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _buildTopicBackground(),
                    new Align(
                      alignment: Alignment.bottomRight,
                      child: new Container(
                        margin: EdgeInsets.only(bottom: 15.0, right: 15.0),
                        height: 35.0,
                        width: 75.0,
                        child: new RaisedButton(
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                _tabController,
              ),
              pinned: true,
            ),
          ];
        },
//        body: new TabBarView(controller: _tabController, children: [
//          new SliverList(
//            delegate: new SliverChildListDelegate(
//                new List<Widget>.generate(20, (int i) {
//                  return _buildTile(context,i);
//                })),
//          ),
//          new SliverList(
//            delegate: new SliverChildListDelegate(
//                new List<Widget>.generate(80, (int i) {
//                  return _buildTile(context,i);
//                })),
//          ),
//        ]),
        body: HomePageBody(
          widget.topicName,
          tabController: _tabController,
          scrollController: _scrollController,
        ),
//          body: new TabBarView(
//            controller: _tabController,
//            children: [
//              new TopicDetailChildPage(
//                  TopicDetailPresenter.TYPE_HOT, widget.topicName),
//              new TopicDetailChildPage(
//                  TopicDetailPresenter.TYPE_NEW, widget.topicName),
//            ],
//          ),
      ),
    );
  }

  Widget _buildTopicBackground() {
    if (_topicBean == null || TextUtils.isEmpty(_topicBean.background)) {
      return new Image.asset(
        'images/bg_topic_detail_placeholder.png',
        fit: BoxFit.fill,
        height: _appBarHeight,
      );
    } else {
      return new Image.network(
        _topicBean.background,
        fit: BoxFit.fill,
        height: _appBarHeight,
      );
    }
  }

  @override
  TopicDetailPresenter newInstance() {
    return new TopicDetailPresenter();
  }

  @override
  void getTopicDetail(TopicBean topicBean) {
    setState(() {
      this._topicBean = topicBean;
    });
  }

  @override
  void getPosts(List<PostBean> posts) {}
}

class HomePageBody extends StatefulWidget {
  HomePageBody(this.topicName, {this.scrollController, this.tabController});

  final ScrollController scrollController;
  final TabController tabController;
  final String topicName;

  HomePageBodyState createState() => new HomePageBodyState();
}

class HomePageBodyState extends State<HomePageBody> {
  Key _key = new PageStorageKey({});
  bool _innerListIsScrolled = false;

  void _updateScrollPosition() {
//    if (!_innerListIsScrolled &&
//        widget.scrollController.position.extentAfter == 0.0) {
//      setState(() {
//        _innerListIsScrolled = true;
//      });
//    } else if (_innerListIsScrolled &&
//        widget.scrollController.position.extentAfter > 0.0) {
//      setState(() {
//        _innerListIsScrolled = false;
//        // Reset scroll positions of the TabBarView pages
//        _key = new PageStorageKey({});
//      });
//    }
  }

  @override
  void initState() {
    widget.scrollController.addListener(_updateScrollPosition);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateScrollPosition);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new TabBarView(
      controller: widget.tabController,
      key: _key,
      children: [
        new TopicDetailChildPage(
            TopicDetailPresenter.TYPE_HOT, widget.topicName),
        new TopicDetailChildPage(
            TopicDetailPresenter.TYPE_NEW, widget.topicName),
      ],
    );

//    return TabBarView(
//      controller: widget.tabController,
//      key: _key,
//      children: new List<Widget>.generate(2, (int index) {
//        return new SafeArea(
//            top: true,
//            bottom: false,
//            child: new ListView.builder(
//              key: new PageStorageKey<int>(index),
//              itemBuilder: _buildTile,
//            ));
//      }),
//    );
  }

  Widget _buildTile(BuildContext context, int index) {
    return new Container(
      color: Colors.red,
      child: new ListTile(
        title: new Text("Item $index"),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.controller);

  final TabController controller;

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Theme.of(context).cardColor,
      height: kToolbarHeight,
      child: new TabBar(
        controller: controller,
        key: new PageStorageKey<Type>(TabBar),
        labelColor: Colors.black87,
        indicatorColor: FunColors.themeColor,
        tabs: <Widget>[
          new Tab(text: '最热'),
          new Tab(text: '最新'),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//    return oldDelegate.controller != controller;
    return false;
  }
}
