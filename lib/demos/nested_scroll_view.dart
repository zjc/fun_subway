
import 'package:flutter/material.dart';
Widget _buildTile(BuildContext context, int index) {
  return new ListTile(
    title: new Text("Item $index"),
  );
}

const tabCount = 2;

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.yellow),
      home: new TestAppHomePage(),
    );
  }
}

class TestApp1State extends State<TestApp1>{
  List<String> _tabs = ["tab1","tab2"];
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: new NestedScrollView(

        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            new SliverOverlapAbsorber(
              // This widget takes the overlapping behavior of the SliverAppBar,
              // and redirects it to the SliverOverlapInjector below. If it is
              // missing, then it is possible for the nested "inner" scroll view
              // below to end up under the SliverAppBar even when the inner
              // scroll view thinks it has not been scrolled.
              // This is not necessary if the "headerSliverBuilder" only builds
              // widgets that do not overlap the next sliver.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: new SliverAppBar(
                title: const Text('Books'), // This is the title in the app bar.
                pinned: true,
                expandedHeight: 150.0,
                // The "forceElevated" property causes the SliverAppBar to show
                // a shadow. The "innerBoxIsScrolled" parameter is true when the
                // inner scroll view is scrolled beyond its "zero" point, i.e.
                // when it appears to be scrolled below the SliverAppBar.
                // Without this, there are cases where the shadow would appear
                // or not appear inappropriately, because the SliverAppBar is
                // not actually aware of the precise position of the inner
                // scroll views.
                forceElevated: innerBoxIsScrolled,
                bottom: new TabBar(
                  // These are the widgets to put in each tab in the tab bar.
                  tabs: _tabs.map((String name) => new Tab(text: name)).toList(),
                ),
              ),
            ),
          ];
        },
        body: new TabBarView(
          // These are the contents of the tab views, below the tabs.
          children: _tabs.map((String name) {
            return new SafeArea(
              top: false,
              bottom: false,
              child: new Builder(
                // This Builder is needed to provide a BuildContext that is "inside"
                // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                // find the NestedScrollView.
                builder: (BuildContext context) {
                  return new CustomScrollView(
                    // The "controller" and "primary" members should be left
                    // unset, so that the NestedScrollView can control this
                    // inner scroll view.
                    // If the "controller" property is set, then this scroll
                    // view will not be associated with the NestedScrollView.
                    // The PageStorageKey should be unique to this ScrollView;
                    // it allows the list to remember its scroll position when
                    // the tab view is not on the screen.
                    key: new PageStorageKey<String>(name),
                    slivers: <Widget>[
                      new SliverOverlapInjector(
                        // This is the flip side of the SliverOverlapAbsorber above.
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      ),
                      new SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        // In this example, the inner scroll view has
                        // fixed-height list items, hence the use of
                        // SliverFixedExtentList. However, one could use any
                        // sliver widget here, e.g. SliverList or SliverGrid.
                        sliver: new SliverFixedExtentList(
                          // The items in this example are fixed to 48 pixels
                          // high. This matches the Material Design spec for
                          // ListTile widgets.
                          itemExtent: 48.0,
                          delegate: new SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              // This builder is called for each child.
                              // In this example, we just number each list item.
                              return new ListTile(
                                title: new Text('Item $index'),
                              );
                            },
                            // The childCount of the SliverChildBuilderDelegate
                            // specifies how many children this inner list
                            // has. In this example, each tab has a list of
                            // exactly 30 items, but this is arbitrary.
                            childCount: 30,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}

class TestApp1 extends StatefulWidget{
  var _tabs = ["最新","最热"];

  @override
  State<StatefulWidget> createState() {
    return TestApp1State();
  }

}

class TestTabBarDelegate extends SliverPersistentHeaderDelegate {
  TestTabBarDelegate({ this.controller });

  final TabController controller;

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return new Container(
      color: Theme
          .of(context)
          .cardColor,
      height: kToolbarHeight,
      child: new TabBar(
        controller: controller,
        key: new PageStorageKey<Type>(TabBar),
        indicatorColor: Theme
            .of(context)
            .primaryColor,
        tabs: <Widget>[
          new Tab(text: 'one'),
          new Tab(text: 'two'),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant TestTabBarDelegate oldDelegate) {
    return oldDelegate.controller != controller;
  }
}

class TestAppHomePage extends StatefulWidget {
  @override
  TestAppHomePageState createState() => new TestAppHomePageState();
}

class TestAppHomePageState extends State<TestAppHomePage>
    with TickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: tabCount, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Test Title'),
        elevation: 0.0,
      ),
      body: new NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverList(
              delegate: new SliverChildBuilderDelegate(
                _buildTile,
                childCount: 12,
              ),
            ),
            new SliverPersistentHeader(
              pinned: true,
              delegate: new TestTabBarDelegate(controller: _tabController),
            ),
          ];
        },
        body: new TestHomePageBody(
          tabController: _tabController,
          scrollController: _scrollController,
        ),
      ),
    );
  }
}

class TestHomePageBody extends StatefulWidget {
  TestHomePageBody({ this.scrollController, this.tabController });

  final ScrollController scrollController;
  final TabController tabController;

  TestHomePageBodyState createState() => new TestHomePageBodyState();
}

class TestHomePageBodyState extends State<TestHomePageBody> {
  Key _key = new PageStorageKey({});
  bool _innerListIsScrolled = false;

  void _updateScrollPosition() {
    if (!_innerListIsScrolled && widget.scrollController.position.extentAfter == 0.0) {
      setState(() {
        _innerListIsScrolled = true;
      });
    } else if (_innerListIsScrolled && widget.scrollController.position.extentAfter > 0.0) {
      setState(() {
        _innerListIsScrolled = false;
        // Reset scroll positions of the TabBarView pages
        _key = new PageStorageKey({});
      });
    }
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
      children: new List<Widget>.generate(tabCount, (int index) {
        return new ListView.builder(
          key: new PageStorageKey<int>(index),
          itemBuilder: _buildTile,
        );
      }),
    );
  }
}