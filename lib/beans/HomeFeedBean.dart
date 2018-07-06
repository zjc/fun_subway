import 'package:fun_subway/beans/BaseBean.dart';
import 'package:fun_subway/beans/HomeBanner.dart';
import 'package:fun_subway/beans/PostBean.dart';
import 'package:fun_subway/beans/TopicBean.dart';

class HomeFeedBean extends BaseBean {
  final List<HomeBanner> banners;
  final List<String> hotTags;

  final List<PostBean> posts;
  final int topicIndex;
  final List<TopicBean> topics;
  final int page;

  HomeFeedBean(
      {this.banners,
      this.hotTags,
      this.posts,
      this.topicIndex,
      this.topics,
      this.page});

  factory HomeFeedBean.fromJson(Map<String, dynamic> map) {
    return _instanceHomeBean(map);
  }

  static HomeFeedBean _instanceHomeBean(Map<String, dynamic> dataMap) {
    List<HomeBanner> homeBanners;
    List banners = dataMap["banners"];
    if (banners != null && banners.isNotEmpty) {
      homeBanners = banners.map((map) {
        return HomeBanner.fromJson(map);
      }).toList();
    }

    List hotTags = dataMap["hotTags"].cast<String>();

    List<PostBean> postBeans;
    List posts = dataMap["posts"];
    if (posts != null && posts.isNotEmpty) {
      postBeans = posts.map((map) {
        return PostBean.fromJson(map);
      }).toList();
    }

    int topicIndex = dataMap["topicIndex"];

    List<TopicBean> topicBeans;
    List topics = dataMap["topics"];
    if (topics != null && topics.isNotEmpty) {
      topicBeans = topics.map((map) {
        return TopicBean.fromJson(map);
      }).toList();
    }

    int page = dataMap["page"];

    return HomeFeedBean(
        banners: homeBanners,
        hotTags: hotTags,
        posts: postBeans,
        topicIndex: topicIndex,
        topics: topicBeans,
        page: page);
  }

  Map<String, dynamic> toJson() => {
        'banners': banners,
        'hotTags': hotTags,
        'topicIndex': topicIndex,
        'topics': topics,
        'page': page,
      };
}
