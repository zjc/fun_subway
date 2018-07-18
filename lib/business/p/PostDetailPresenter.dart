import 'package:fun_subway/business/beans/CommentsBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/model/PostModel.dart';
import 'package:fun_subway/business/view/PostDetailView.dart';
import 'package:fun_subway/framework/LoadMorePresenter.dart';
import 'package:fun_subway/utils/Pair.dart';

class PostDetailPresenter extends LoadMorePresenter<PostDetailView, PostModel> {
  static const ITEM_TYPE_POST = 1; //帖子内容
  static const ITEM_TYPE_DIVIDER = 2; //分割线
  static const ITEM_TYPE_COMMENT_LABEL = 3; //全部评论文本标签
  static const ITEM_TYPE_COMMENT = 4; //评论内容
  static const ITEM_TYPE_COMMENT_EMPTY = 5; //评论内容为空

  PostBean mPostBean;

  int mCommentId;

  int mPostId;

  @override
  PostModel newInstance() {
    return new PostModel();
  }

  List<Pair> mPairs = [];

  void fetchPost(int postId) {
    mPostId = postId;
    model.fetchPost(postId).then((responseBean) {
      if (responseBean.isSuccess()) {
        mPairs.clear();
        mPostBean = responseBean.data;
        mPairs.add(new Pair(ITEM_TYPE_POST, mPostBean));
        mPairs.add(new Pair(ITEM_TYPE_DIVIDER, null));
        fetchComments(postId, null);
      }
    });
  }

  void fetchComments(int postId, int id) {
    model.fetchComments(postId, id).then((responeBean) {
      if (responeBean.isSuccess()) {
        CommentsBean commentsBean = responeBean.data;
        if (commentsBean != null &&
            commentsBean.comments != null &&
            commentsBean.comments.isNotEmpty) {
          if (id == null) {
            mPairs.add(new Pair(ITEM_TYPE_COMMENT_LABEL, null));
          }
          for (var commentBean in commentsBean.comments) {
            mPairs.add(new Pair(ITEM_TYPE_COMMENT, commentBean));
          }
          mCommentId = commentsBean.comments.last.id;
        } else {
          if (id == null) {
            //第一次请求的时候id为null，则个时候返回的评论列表是空，才添加
            mPairs.add(new Pair(ITEM_TYPE_COMMENT_EMPTY, null));
          }
        }
      }
      getView()?.fetchCallback(mPairs);
    },onError: (){
      getView()?.fetchCallback(mPairs);
    });
  }

  @override
  void loadMore() {
    fetchComments(mPostId, mCommentId);
  }
}
