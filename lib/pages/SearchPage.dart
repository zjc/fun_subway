import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/SearchResult.dart';
import 'package:fun_subway/business/p/SearchPresenter.dart';
import 'package:fun_subway/business/view/SearchView.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';
import 'package:fun_subway/utils/SearchBloc.dart';
import 'package:fun_subway/utils/SearchState.dart';
import 'package:fun_subway/utils/utils.dart';

class SearchPage extends StatefulWidget {
  int searchType;
  String searchWords;

  SearchPage({this.searchType, this.searchWords});

  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends LoadMoreState<SearchPresenter, SearchPage>
    implements SearchView {
  List<String> _hotWords;

  List<String> _hotTopics;

  List<ImageBean> _imageBeans = [];

  SearchResult _searchResult;

  String inputText;

  FocusNode focusNode;

  SearchBloc bloc;

  bool isComplete = false;

  @override
  void initState() {
    super.initState();
    bloc = SearchBloc(mPresenter);
    focusNode = new FocusNode();
    focusNode.addListener(onFocusChangeListener);
    inputText = widget.searchWords;
    mPresenter.setSearchWords(inputText);
    mPresenter.loadData();
  }

  void onFocusChangeListener() {
    bool isFocus = focusNode?.hasFocus;
    print("isFocus:" + isFocus.toString());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchState>(
      stream: bloc.state,
      initialData: SearchNoTerm(),
      builder:
          (BuildContext buildContext, AsyncSnapshot<SearchState> snapshot) {
        final state = snapshot.data;
        return new Scaffold(
          appBar: new AppBar(
            title: _buildSearchWidget(),
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(SearchState searchState) {
    if (searchState is SearchNoTerm || isComplete) {
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
        widgets.add(_buildSearchHeader()); //搜索到XXX的相关表情，一共有xxx个
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
          controller: mScrollController,
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          children: widgets,
        );
      }
    } else if (searchState is SearchPopulated) {
      SearchPopulated searchPopulated = searchState;
      return new ListView.builder(
          itemCount: searchPopulated.result.length,
          itemBuilder: (context, index) {
            String text = searchPopulated.result[index];
            return new ListTile(
              leading: new Icon(Icons.search),
              title: new Text(text),
              onTap: () {
                focusNode.unfocus();
                inputText = text;
                isComplete = true;
                mPresenter.setSearchWords(inputText);
                mPresenter.fetchSearchResult(inputText);
              },
            );
          });
    } else if (searchState is SearchLoading) {
      return showLoading();
    } else if (searchState is SearchEmpty) {
      return new Text("未检索到<" + inputText + ">相关联的联想词语");
    } else if (searchState is SearchError) {
      return new Text("联想发生错误");
    }else {
      return new Container();
    }
  }

  Widget searchHeaderWidget;

  Widget _buildSearchHeader() {
    if (_searchResult.page == 1 && searchHeaderWidget == null) {
      searchHeaderWidget = new Column(
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
    return searchHeaderWidget;
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
                      isComplete = true;
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

  Widget _buildSearchWidget() {
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
                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: TextUtils.isEmpty(inputText) ? "" : inputText,
                        selection: new TextSelection.collapsed(
                            offset: TextUtils.isEmpty(inputText)
                                ? 0
                                : inputText.length))),
                onChanged: (val) {
                  isComplete = false;
                  inputText = val;
                  print("======>onChanged:"+val);
                  bloc.onTextChanged.add(val);
                },
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
