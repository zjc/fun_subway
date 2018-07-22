import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/model/PostModel.dart';
import 'package:fun_subway/business/model/UserProfileModel.dart';
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

  void follow(PostBean postBean) {
    userProfileModel.follow(postBean.userId).then((responseBean) {
      if (responseBean.isSuccess()) {
        postBean.followed = responseBean.data.followed;
        getView()?.followSuccess(postBean);
        return;
      }
      getView()?.followFail();
    });
  }

  UserProfileModel userProfileModel = new UserProfileModel();

  void unFollow(PostBean postBean) {
    userProfileModel.unFollow(postBean.userId).then((responseBean) {
      if (responseBean.isSuccess()) {
        postBean.followed = responseBean.data.followed;
        getView()?.unFollowSuccess(postBean);
        return;
      }
      getView()?.unFollowFail();
    });
  }
}
