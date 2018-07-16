import 'package:fun_subway/business/view/SearchView.dart';
import 'package:fun_subway/business/model/SearchModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/utils/utils.dart';

class SearchPresenter extends BasePresenter<SearchView, SearchModel> {
  static const int SEARCH_HEAD = 1;

  static const int SEARCH = 2;

  static const int SEARCH_EXPRESSION = 3;

  static const int SEARCH_HINT = 4;

  @override
  SearchModel newInstance() {
    return new SearchModel();
  }

  String searchWords;
  void setSearchWords(String words){
    this.searchWords = words;
  }

  void loadData(){
    if(TextUtils.isEmpty(searchWords)){
      fetHotSearch();
      fetchHotTopic();
    }else{
      fetchSearchResult(searchWords);
    }
  }

  void fetHotSearch(){
    model.fetchHotSearch().then((responseBean){
      if(responseBean.isSuccess()){
        getView()?.getHotWords(responseBean.data.tags);
      }
    });
  }


  void fetchHotTopic(){
    model.fetchHotTopic().then((responseBean){
      if(responseBean.isSuccess()){
        getView()?.getHotTopics(responseBean.data.topicNames);
      }
    });
  }

  void fetchSearchResult(String searchWords){

  }
}
