import 'dart:convert';

import 'package:fun_subway/beans/HomeBanner.dart';
import 'package:fun_subway/beans/HomeFeedBean.dart';
import 'package:fun_subway/beans/PostBean.dart';
import 'package:fun_subway/beans/TopicBean.dart';
import 'package:fun_subway/utils/Pair.dart';
import 'package:fun_subway/view/HomeView.dart';
import 'package:fun_subway/model/HomeModel.dart';
import 'package:fun_subway/framework/BasePresenter.dart';

class HomePresenter extends BasePresenter<HomeView, HomeModel> {
  @override
  HomeModel newInstance() {
    return new HomeModel();
  }

  static final ITEM_TYPE_HOME_BANNER = 1; //首页banner图
  static final ITEM_TYPE_HOME_HOT_TAGS = 2; //热门标签
  static final ITEM_TYPE_HOME_TOPIC = 3; //话题
  static final ITEM_TYPE_HOME_LAST_VIEWD = 4; //上次观看到这里
  static final ITEM_TYPE_HOME_POST = 5; //动态内容

  List<Pair> mDataSource = [];

  var topicIndex = 0;

  HomeFeedBean homeFeedBean;

  void fetchHomeData() {
    fetchFeedList(1, 10);
  }

  void fetchFeedList(int pageNum, int pageSize) {
    model.fetchFeedList(pageNum, pageSize).then((bean) {
      homeFeedBean = bean.data;
      if (pageNum == 1) {
        if (homeFeedBean.posts != null && homeFeedBean.posts.isNotEmpty) {
          showSimpleSnackbar(
              "为您更新" + homeFeedBean.posts.length.toString() + "条动态");
        }
        updateHomeData();
        updateLastViewed();
        addHotTopic();
      }
      //callback
    });
  }

  void clearData() {
    for (int i = 0; i < mDataSource.length; i++) {
      Pair pair = mDataSource[i];
      if (pair.first.cast<int>() == ITEM_TYPE_HOME_BANNER) {
        mDataSource.removeAt(i);
        i--;
        continue;
      }

      if (pair.first.cast<int>() == ITEM_TYPE_HOME_HOT_TAGS) {
        mDataSource.removeAt(i);
        i--;
        continue;
      }

      if (pair.first.cast<int>() == ITEM_TYPE_HOME_TOPIC) {
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
      new Pair(ITEM_TYPE_HOME_LAST_VIEWD, new Object());

  void updateLastViewed() {
    mDataSource.remove(lastViewedPair);
    for (int i = 0; i < mDataSource.length; i++) {
      Pair pair = mDataSource[i];
      if (pair.first.cast<int>() == ITEM_TYPE_HOME_POST) {
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
    if (topicIndex > mDataSource.length) {
      mDataSource.add(hotTopicsPair);
    } else {
      mDataSource.insert(topicIndex, hotTopicsPair);
    }
  }
}
