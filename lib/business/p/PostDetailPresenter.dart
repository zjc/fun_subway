import 'package:fun_subway/business/model/PostModel.dart';
import 'package:fun_subway/business/view/PostDetailView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class PostDetailPresenter extends BasePresenter<PostDetailView, PostModel> {
  @override
  PostModel newInstance() {
    return new PostModel();
  }
}
