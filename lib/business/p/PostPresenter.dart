import 'package:fun_subway/business/model/PostModel.dart';
import 'package:fun_subway/business/view/PostView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class PostPresenter extends BasePresenter<PostView, PostModel> {
  @override
  PostModel newInstance() {
    return new PostModel();
  }
}
