import 'package:flutter/material.dart';
import 'package:fun_subway/business/p/SearchPresenter.dart';
import 'package:fun_subway/business/view/SearchView.dart';
import 'package:fun_subway/framework/BaseState.dart';

class SearchPage extends StatefulWidget {
  String searchType;
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
  Widget build(BuildContext context) {
      return new Text("search");
  }

  @override
  SearchPresenter newInstance() {
    return new SearchPresenter();
  }

}
