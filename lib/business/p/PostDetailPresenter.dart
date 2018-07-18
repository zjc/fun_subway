import 'package:fun_subway/business/model/PostModel.dart';
import 'package:fun_subway/business/view/PostDetailView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMorePresenter.dart';

class PostDetailPresenter extends LoadMorePresenter<PostDetailView, PostModel> {

  static const ITEM_TYPE_POST = 1;//帖子内容
  static const ITEM_TYPE_DIVIDER = 2;//分割线
  static const ITEM_TYPE_COMMENT_LABEL = 3;//全部评论文本标签
  static const ITEM_TYPE_COMMENT = 4;//评论内容
  static const ITEM_TYPE_COMMENT_EMPTY = 5;//评论内容为空



  @override
  PostModel newInstance() {
    return new PostModel();
  }

  void fetchPost(int postId){
    //RXDart合并两次请求的数据流
  }

  @override
  void loadMore() {

  }
}
