import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/SearchResult.dart';
import 'package:fun_subway/business/p/SearchPresenter.dart';
import 'package:fun_subway/business/view/SearchView.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/utils/FunColors.dart';
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

  @override
  void initState() {
    super.initState();
    mPresenter.setSearchWords(widget.searchWords);
    mTextEditingController =
        new TextEditingController(text: widget.searchWords);
    mPresenter.loadData();
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
    if (TextUtils.isEmpty(widget.searchWords)) {
      return new ListView(
        children: <Widget>[
          _buildHotSearch(),
          buildDivider(10.0),
          _buildHotTopic(),
        ],
      );
    } else {
      return new Text("321");
    }
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
                      //TODO 检索关键字
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
                return new InkWell(onTap: (){
                  //TODO jump to topic
                  print("value:"+value);
                },child: new Container(
                  padding: EdgeInsets.all(10.0),
                  child: new Text("#" + value + "#"),
                ),);
              }).toList(),
            ),
    );
  }

  TextEditingController mTextEditingController;

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
    // TODO: implement getAssociationTags
  }

  @override
  void getSearchResult(List<SearchResult> searchResults) {
    // TODO: implement getSearchResult
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
