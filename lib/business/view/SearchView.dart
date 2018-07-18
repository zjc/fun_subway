import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/SearchResult.dart';
import 'package:fun_subway/framework/BaseView.dart';
import 'package:fun_subway/framework/LoadMoreView.dart';

abstract class SearchView extends LoadMoreView {
  void getHotWords(List<String> words);

  void getHotTopics(List<String> topics);

  void getSearchResult(SearchResult searchResult,List<ImageBean> imageBeans);

}
