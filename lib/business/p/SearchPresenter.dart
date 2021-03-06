import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/AssociationTagBean.dart';
import 'package:fun_subway/business/beans/ResponseBean.dart';
import 'package:fun_subway/business/beans/SearchResult.dart';
import 'package:fun_subway/business/view/SearchView.dart';
import 'package:fun_subway/business/model/SearchModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMorePresenter.dart';
import 'package:fun_subway/utils/utils.dart';

class SearchPresenter extends LoadMorePresenter<SearchView, SearchModel> {
  static const int SEARCH_HEAD = 1;

  static const int SEARCH = 2;

  static const int SEARCH_EXPRESSION = 3;

  static const int SEARCH_HINT = 4;

  @override
  SearchModel newInstance() {
    return new SearchModel();
  }

  String searchWords;

  String inputText;

  void setInputText(String inputText) {
    this.inputText = inputText;
  }

  void setSearchWords(String words) {
    this.searchWords = words;
  }

  @override
  void loadMore() {
    fetchSearchResultByPage(inputText, mSearchResult.page + 1);
  }

  void loadData() {
    if (TextUtils.isEmpty(searchWords)) {
      fetHotSearch();
      fetchHotTopic();
    } else {
      inputText = searchWords;
      fetchSearchResult(searchWords);
    }
  }

  void fetHotSearch() {
    model.fetchHotSearch().then((responseBean) {
      if (responseBean.isSuccess()) {
        getView()?.getHotWords(responseBean.data.tags);
      }
    });
  }

  String getTag() {
    if (mSearchResult == null) {
      return "";
    }
    return TextUtils.isEmpty(mSearchResult.adviceTag)
        ? inputText
        : mSearchResult.adviceTag;
  }

  Size getSearchResultImageSize(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width - 10;
    displayWidth = displayWidth - 3 * 2;
    return new Size(displayWidth / 3, displayWidth / 3);
  }

  void fetchHotTopic() {
    model.fetchHotTopic().then((responseBean) {
      if (responseBean.isSuccess()) {
        getView()?.getHotTopics(responseBean.data.topicNames);
      }
    });
  }

  SearchResult mSearchResult;

  void fetchSearchResult(String searchWords) {
    fetchSearchResultByPage(searchWords, 1);
  }

  int pageSize = 30;

  void fetchSearchResultByPage(String searchWords, int pageNum) {
    this.inputText = searchWords;
    model
        .fetchSearchResult(searchWords, pageNum, pageSize)
        .then((responseBean) {
      if (responseBean.isSuccess()) {
        mSearchResult = responseBean.data;
        getView()?.getSearchResult(mSearchResult, mSearchResult.rows);
      }
    });
  }

  void fetchSearchResultWithoutCheck(String searchWords) {
    this.inputText = searchWords;
    model
        .fetchSearchResultByCheck(searchWords, 1, pageSize, false)
        .then((responseBean) {});
  }

  void fetchAssociation(String inputText) {
    model.fetchAssociation(inputText).then((responseBean) {
//      getView()?.getAssociationTags(responseBean.data.tags);
    });
  }

  Future<AssociationTagBean> fetchAssociationByInputText(String inputText) async{
    ResponseBean<AssociationTagBean> responseBean = await model.fetchAssociation(inputText);
    return responseBean.data;
  }
}
