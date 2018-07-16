import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    mTextEditingController =
        new TextEditingController(text: widget.searchWords);
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
    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Text("热门搜索"),
            padding: EdgeInsets.only(
              bottom: 15.0
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotTopic() {
    return new Column();
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
}
