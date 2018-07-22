import 'package:fun_subway/business/beans/TopicDetailBean.dart';
import 'package:fun_subway/business/model/TopicModel.dart';
import 'package:fun_subway/business/view/TopicDetailView.dart';
import 'package:fun_subway/framework/BasePresenter.dart';
import 'package:fun_subway/framework/LoadMorePresenter.dart';

class TopicDetailPresenter
    extends LoadMorePresenter<TopicDetailView, TopicModel> {
  static const int TYPE_HOT = 0, TYPE_NEW = 1;

  @override
  TopicModel newInstance() {
    return new TopicModel();
  }

  final int PAGE_SIZE = 30;

  int mType = TYPE_HOT; //0:最热 1:最新
  void setType(int type) {
    this.mType = type;
  }

  String mTopicName;

  void setTopicName(String topicName) {
    this.mTopicName = topicName;
  }

  void fetchData() {
    if (mType == TYPE_HOT) {
      loadHot(1);
    } else {
      loadNew(1);
    }
  }

  TopicDetailBean topicDetailBean;

  void loadHot(int page) {
    model.loadHotTopic(mTopicName, page, PAGE_SIZE).then((responseBean) {
      if (responseBean.isSuccess()) {
        topicDetailBean = responseBean.data;
        getView()?.getPosts(topicDetailBean.posts);
      }
    });
  }

  void loadNew(int page) {
    model.loadNewTopic(mTopicName, page, PAGE_SIZE).then((responseBean) {
      if (responseBean.isSuccess()) {
        topicDetailBean = responseBean.data;
        getView()?.getPosts(topicDetailBean.posts);
      }
    });
  }

  void fetchTopicDetail(String topicName) {
    model.fetchTopicDetail(topicName).then((responseBean) {
      if (responseBean.isSuccess()) {
        getView()?.getTopicDetail(responseBean.data);
      }
    });
  }

  @override
  void loadMore() {
    if (topicDetailBean == null) {
      return;
    }
    int page = topicDetailBean.page + 1;
    if (mType == TYPE_HOT) {
      loadHot(page);
    } else {
      loadNew(page);
    }
  }
}
