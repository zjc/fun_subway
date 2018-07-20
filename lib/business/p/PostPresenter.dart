import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/model/PostModel.dart';
import 'package:fun_subway/business/view/PostView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class PostPresenter extends BasePresenter<PostView, PostModel> {
  @override
  PostModel newInstance() {
    return new PostModel();
  }

  void like(PostBean postBean) {
    model.like(postBean.id).then((responseBean) {
      if (responseBean.isSuccess()) {
        postBean.like = true;
        postBean.likeCount += 1;
        getView()?.likeSuccess(postBean);
        return;
      }
      getView()?.likeFail();
    });
  }

  void unlike(PostBean postBean) {
    model.unlike(postBean.id).then((responseBean) {
      if (responseBean.isSuccess()) {
        postBean.like = false;
        if (postBean.likeCount != 0) {
          postBean.likeCount -= 1;
        }
        getView()?.unlikeSuccess(postBean);
        return;
      }
      getView()?.likeFail();
    });
  }
}
