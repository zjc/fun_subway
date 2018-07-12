import 'package:fun_subway/business/view/SearchView.dart';
import 'package:fun_subway/business/model/SearchModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class SearchPresenter extends BasePresenter<SearchView, SearchModel> {
  @override
  SearchModel newInstance() {
    return new SearchModel();
  }
}
