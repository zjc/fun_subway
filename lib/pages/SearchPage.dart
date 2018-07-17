import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/beans/SearchResult.dart';
import 'package:fun_subway/business/p/SearchPresenter.dart';
import 'package:fun_subway/business/view/SearchView.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';
import 'package:fun_subway/utils/Pair.dart';
import 'package:fun_subway/utils/utils.dart';

class SearchPage extends StatefulWidget {
  int searchType;
  String searchWords;

  SearchPage({this.searchType, this.searchWords});

  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }
}

class SearchState extends BaseState<SearchPresenter, SearchPage>
    implements SearchView {
  List<String> _hotWords;

  List<String> _hotTopics;

  List<String> _associationTags;

  List<ImageBean> _imageBeans = [];

  SearchResult _searchResult;

  bool isFocus = false;

  String inputText;

  TextEditingController mTextEditingController;

  ScrollController _scrollController;

  FocusNode focusNode;

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
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(_scrollListener);
    focusNode = new FocusNode();
    focusNode.addListener(onFocusChangeListener);
    inputText = widget.searchWords;
    mPresenter.setSearchWords(inputText);
    mPresenter.loadData();
  }

  void onFocusChangeListener() {
    isFocus = focusNode?.hasFocus;
    print("isFocus:" + isFocus.toString());
  }

  void onTextChangeListener() {
    String nowText = mTextEditingController?.text;
    if (!TextUtils.isEmpty(nowText) && !TextUtils.equals(inputText, nowText)) {
      inputText = nowText;
      //delay 200ms 请求网络，如果正在请求取消
      mPresenter.fetchAssociation(inputText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: _buildSearchWidget(),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isFocus && !TextUtils.isEmpty(inputText)) {
      if (_associationTags == null || _associationTags.isEmpty) {
        return showLoading();
      }
      return new ListView.builder(
          itemCount: _associationTags.length,
          itemBuilder: (context, index) {
            String text = _associationTags[index];
            return new ListTile(
              leading: new Icon(Icons.search),
              title: new Text(text),
              onTap: () {
                focusNode.unfocus();
                inputText = text;
                mPresenter.setSearchWords(inputText);
                mPresenter.fetchSearchResult(inputText);
              },
            );
          });
    } else {
      if (TextUtils.isEmpty(inputText)) {
        return new ListView(
          children: <Widget>[
            _buildHotSearch(), //推荐的热门关键字
            buildDivider(10.0),
            _buildHotTopic(), //热门话题
          ],
        );
      } else {
        if (_searchResult == null) {
          return showLoading();
        }

        List<Widget> widgets = [];
        Widget searchHeader = buildSearchHeader(); //搜索到XXX的相关表情，一共有xxx个
        if (searchHeader != null) {
          widgets.add(searchHeader);
        }
        //添加9宫格图片列表
        widgets.add(GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          childAspectRatio: 1.0,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          controller: new ScrollController(),
          children: _imageBeans.map((imageBean) {
            Size size = mPresenter.getSearchResultImageSize(context);
            String displayUrl =
                ImageBean.getDisplayUrl(isNetworkAvailable, isWifi, imageBean);
            return new InkWell(
              child: buildCardImageItem(displayUrl, size.width, size.height),
              onTap: () {
                FunRouteFactory.go2ImagePreview(
                    context, imageBean, _imageBeans);
              },
            );
          }).toList(),
        ));

        return new ListView(
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          children: widgets,
        );
      }
    }
  }

  Widget buildSearchHeader() {
    if (_searchResult.page == 1) {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildDivider(10.0),
          new Container(
            padding: EdgeInsets.only(left: 3.0, top: 15.0, bottom: 15.0),
            child: new RichText(
              text: new TextSpan(
                  text: "搜索到",
                  style: new TextStyle(color: FunColors.c_333),
                  children: [
                    new TextSpan(
                        text: mPresenter.getTag(),
                        style: new TextStyle(color: FunColors.themeColor)),
                    new TextSpan(
                        text: "的相关表情",
                        style: new TextStyle(color: FunColors.c_333)),
                    new TextSpan(
                        text: _searchResult.total.toString(),
                        style: new TextStyle(color: FunColors.themeColor)),
                    new TextSpan(
                        text: "个",
                        style: new TextStyle(color: FunColors.c_333)),
                  ]),
            ),
          )
        ],
      );
    }
    return null;
  }

  Widget _buildHotSearch() {
    return new ListTile(
      title: new Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 15.0),
        child: new Text("热门搜索", textAlign: TextAlign.start),
      ),
      subtitle: (_hotWords == null || _hotWords.isEmpty)
          ? new Center(
              child: new Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text("暂无热词"),
              ),
            )
          : new Wrap(
              children: _hotWords.map((value) {
                return new Padding(
                  padding: EdgeInsets.all(4.0),
                  child: new ActionChip(
                    label: new Text(value),
                    onPressed: () {
                      inputText = value;
                      mPresenter.setSearchWords(value);
                      mPresenter.fetchSearchResult(value);
                    },
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildHotTopic() {
    return new ListTile(
      title: new Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 15.0),
        child: new Text("热门话题", textAlign: TextAlign.start),
      ),
      subtitle: (_hotTopics == null || _hotTopics.isEmpty)
          ? new Center(
              child: new Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text("暂无话题"),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              childAspectRatio: 4.0,
              controller: new ScrollController(),
              shrinkWrap: true,
              children: _hotTopics.map((value) {
                return new InkWell(
                  onTap: () {
                    //TODO jump to topic
                    print("value:" + value);
                  },
                  child: new Container(
                    padding: EdgeInsets.all(10.0),
                    child: new Text("#" + value + "#"),
                  ),
                );
              }).toList(),
            ),
    );
  }

  void clearTextEditingController() {
    if (mTextEditingController != null) {
      mTextEditingController.removeListener(onTextChangeListener);
      mTextEditingController = null;
    }
  }

  Widget _buildSearchWidget() {
    clearTextEditingController();
    mTextEditingController = new TextEditingController(text: inputText);
    mTextEditingController.addListener(onTextChangeListener);
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: new Container(
            height: 36.0,
            decoration: new BoxDecoration(
                color: new Color(0xfff7f7f7),
                borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                border: new Border.all(color: Colors.grey, width: 0.5)),
            child: new TextField(
                focusNode: focusNode,
                controller: mTextEditingController,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 10.0, top: 4.0, right: 10.0),
                  hintText: "搜索你想要的表情",
                )),
          ),
        ),
        new InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new Text(
              "取消",
              style: new TextStyle(color: FunColors.c_666, fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }

  @override
  SearchPresenter newInstance() {
    return new SearchPresenter();
  }

  @override
  void getAssociationTags(List<String> tags) {
    setState(() {
      this._associationTags = tags;
    });
  }

  @override
  void getSearchResult(SearchResult searchResults, List<ImageBean> imageBeans) {
    setState(() {
      this._searchResult = searchResults;
      if (searchResults.page == 1) {
        _imageBeans.clear();
      }
      if (imageBeans != null && imageBeans.isNotEmpty) {
        _imageBeans.addAll(imageBeans);
      } else {
        showToast("没有更多数据显示");
      }
    });
  }

  @override
  void getHotTopics(List<String> topics) {
    setState(() {
      _hotTopics = topics;
    });
  }

  @override
  void getHotWords(List<String> words) {
    setState(() {
      _hotWords = words;
    });
  }
}
