import 'package:fun_subway/business/model/PostModel.dart';
import 'package:fun_subway/business/view/PostPublishView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class PostPublishPresenter extends BasePresenter<PostPublishView, PostModel> {
  @override
  PostModel newInstance() {
    return new PostModel();
  }

}
