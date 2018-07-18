import 'package:fun_subway/business/model/PostModel.dart';
import 'package:fun_subway/business/view/PostDetailView.dart';
import 'package:fun_subway/business/view/UserPostView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMorePresenter.dart';

class UserPostPresenter extends LoadMorePresenter<UserPostView, PostModel> {
  @override
  PostModel newInstance() {
    return new PostModel();
  }

  @override
  void loadMore() {
    // TODO: implement loadMore
  }
}
