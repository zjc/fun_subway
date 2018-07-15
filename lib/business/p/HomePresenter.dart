import 'dart:convert';

import 'package:fun_subway/business/beans/HomeBanner.dart';
import 'package:fun_subway/business/beans/HomeFeedBean.dart';
import 'package:fun_subway/business/beans/PostBean.dart';
import 'package:fun_subway/business/beans/TopicBean.dart';
import 'package:fun_subway/utils/Pair.dart';
import 'package:fun_subway/business/view/HomeView.dart';
import 'package:fun_subway/business/model/HomeModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class HomePresenter extends BasePresenter<HomeView, HomeModel> {
  @override
  HomeModel newInstance() {
    return new HomeModel();
  }

  static const int ITEM_TYPE_HOME_BANNER = 1; //首页banner图
  static const int ITEM_TYPE_HOME_HOT_TAGS = 2; //热门标签
  static const int ITEM_TYPE_HOME_TOPIC = 3; //话题
  static const int ITEM_TYPE_HOME_LAST_VIEWED = 4; //上次观看到这里
  static const int ITEM_TYPE_HOME_POST = 5; //动态内容

  List<Pair> mDataSource = [];

  var topicIndex = 0;

  HomeFeedBean homeFeedBean;

  var pageSize = 10;

  void fetchHomeData() {
    fetchFeedList(1, pageSize);
  }

  void loadMore() {
    fetchFeedList(homeFeedBean.page + 1, pageSize);
  }

  void fetchFeedList(int pageNum, int pageSize) {
    model.fetchFeedList(pageNum, pageSize).then((bean) {
      homeFeedBean = bean.data;
      if (homeFeedBean != null) {
        if (pageNum == 1) {
          if (homeFeedBean.posts != null && homeFeedBean.posts.isNotEmpty) {
            showSimpleSnackbar(
                "为您更新" + homeFeedBean.posts.length.toString() + "条动态");
          }
          topicIndex = homeFeedBean.topicIndex;
          updateHomeData();
          updateLastViewed();
          addHotTopic();
        } else {
          if (homeFeedBean.posts != null && homeFeedBean.posts.isNotEmpty) {
            List<Pair> postPairs = createPostPairs(homeFeedBean.posts);
            mDataSource.addAll(postPairs);
          }
        }

        if (getView() != null) {
          getView().callback(mDataSource);
        }
      }
    }, onError: (exception) {
      print("===========>");
      print(exception);
      print("===========>");
      getView().showError();
    });
  }

  void clearData() {
    for (int i = 0; i < mDataSource.length; i++) {
      Pair pair = mDataSource[i];
      if (pair.first == ITEM_TYPE_HOME_BANNER) {
        mDataSource.removeAt(i);
        i--;
        continue;
      }

      if (pair.first == ITEM_TYPE_HOME_HOT_TAGS) {
        mDataSource.removeAt(i);
        i--;
        continue;
      }

      if (pair.first == ITEM_TYPE_HOME_TOPIC) {
        mDataSource.removeAt(i);
        break;
      }
    }
  }

  void updateHomeData() {
    clearData();
    if (homeFeedBean.banners != null && homeFeedBean.banners.isNotEmpty) {
      Pair<int, List<HomeBanner>> bannerPair =
          new Pair(ITEM_TYPE_HOME_BANNER, homeFeedBean.banners);
      if (mDataSource.length > 0) {
        mDataSource.insert(0, bannerPair);
      } else {
        mDataSource.add(bannerPair);
      }
      topicIndex++;
    }

    if (homeFeedBean.hotTags != null && homeFeedBean.hotTags.isNotEmpty) {
      Pair<int, List<String>> hotTagPair =
          new Pair(ITEM_TYPE_HOME_HOT_TAGS, homeFeedBean.hotTags);
      if (mDataSource.length > 0) {
        mDataSource.insert(1, hotTagPair);
      } else {
        mDataSource.add(hotTagPair);
      }
      topicIndex++;
    }
  }

  Pair<int, Object> lastViewedPair =
      new Pair(ITEM_TYPE_HOME_LAST_VIEWED, new Object());

  void updateLastViewed() {
    mDataSource.remove(lastViewedPair);
    for (int i = 0; i < mDataSource.length; i++) {
      Pair pair = mDataSource[i];
      if (pair.first == ITEM_TYPE_HOME_POST) {
        mDataSource.insert(i, lastViewedPair);
        break;
      }
    }
    List<Pair> postPairs = createPostPairs(homeFeedBean.posts);
    if (postPairs.length > 0) {
      int lastViewedIndex = mDataSource.indexOf(lastViewedPair);
      if (lastViewedIndex == -1) {
        mDataSource.addAll(postPairs);
      } else {
        mDataSource.insertAll(lastViewedIndex, postPairs);
      }
    }
  }

  List<Pair> createPostPairs(List<PostBean> mPosts) {
    List<Pair> postPairs = [];
    if (mPosts != null && mPosts.length > 0) {
      for (int i = 0; i < mPosts.length; i++) {
        PostBean homePostBean = mPosts[i];
        Pair postBeanPair = new Pair(ITEM_TYPE_HOME_POST, homePostBean);
        postPairs.add(postBeanPair);
      }
    }
    return postPairs;
  }

  void addHotTopic() {
    Pair<int, List<TopicBean>> hotTopicsPair =
        new Pair(ITEM_TYPE_HOME_TOPIC, homeFeedBean.topics);
    print("");
    if (topicIndex > mDataSource.length) {
      mDataSource.add(hotTopicsPair);
    } else {
      mDataSource.insert(topicIndex, hotTopicsPair);
    }
  }
}
