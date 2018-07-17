import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/SearchResult.dart';
import 'package:fun_subway/framework/BaseView.dart';

abstract class SearchView extends BaseView {
  void getHotWords(List<String> words);

  void getHotTopics(List<String> topics);

  void getAssociationTags(List<String> tags);

  void getSearchResult(SearchResult searchResult,List<ImageBean> imageBeans);

}
