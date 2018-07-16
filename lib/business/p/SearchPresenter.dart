import 'package:fun_subway/business/view/SearchView.dart';
import 'package:fun_subway/business/model/SearchModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class SearchPresenter extends BasePresenter<SearchView, SearchModel> {
  static const int SEARCH_HEAD = 1;

  static const int SEARCH = 2;

  static const int SEARCH_EXPRESSION = 3;

  static const int SEARCH_HINT = 4;

  @override
  SearchModel newInstance() {
    return new SearchModel();
  }
}
