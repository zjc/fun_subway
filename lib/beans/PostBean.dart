import 'package:fun_subway/beans/BaseBean.dart';
import 'package:fun_subway/beans/CommentBean.dart';
import 'package:fun_subway/beans/ImageBean.dart';

class PostBean extends BaseBean {
  final String content;
  final int commentCount;
  final bool dislike;
  final int dislikeCount;
  final int followed;
  final bool like;
  final int likeCount;
  final int gmtCreate;
  final String profilePicture;
  final int id;
  final List<ImageBean> memeImgs;
  final String nickname;
  final bool show;
  final String topicNames;
  final int userId;
  final List<ImageBean> showImgs;
  final bool topic;
  final CommentBean great;
  final bool ellipses;

  PostBean(
      {this.content,
      this.commentCount,
      this.dislike,
      this.dislikeCount,
      this.followed,
      this.like,
      this.likeCount,
      this.gmtCreate,
      this.profilePicture,
      this.id,
      this.memeImgs,
      this.nickname,
      this.show,
      this.topicNames,
      this.userId,
      this.showImgs,
      this.topic,
      this.great,
      this.ellipses});

  factory PostBean.fromJson(Map<String, dynamic> map) {
    return PostBean(
      content: map["content"],
      commentCount: map["commentCount"],
      dislike: map["dislike"],
      dislikeCount: map["dislikeCount"],
      followed: map["followed"],
      like: map["like"],
      likeCount: map["likeCount"],
      gmtCreate: map["gmtCreate"],
      profilePicture: map["profilePicture"],
      id: map["id"],
      memeImgs: _instanceImageBeans(map["memeImgs"]),
      nickname: map["nickname"],
      show: map["show"],
      topicNames: map["topicNames"],
      userId: map["userId"],
      showImgs: _instanceImageBeans(map["showImgs"]),
      topic: map["topic"],
      great: map["great"],
      ellipses: map["ellipses"],
    );
  }

  static _instanceImageBeans(List list) {
    List<ImageBean> imageBeans;
    if (list != null && list.isNotEmpty) {
      imageBeans = list.map((map) {
        return ImageBean.fromJson(map);
      }).toList();
    }
    return imageBeans;
  }

  Map<String, dynamic> toJson() => {
        "content": content,
        "commentCount": commentCount,
        "dislike": dislike,
        "dislikeCount": dislikeCount,
        "followed": followed,
        "like": like,
        "likeCount": likeCount,
        "gmtCreate": gmtCreate,
        "profilePicture": profilePicture,
        "id": id,
        "memeImgs": memeImgs,
        "nickname": nickname,
        "show": show,
        "topicNames": topicNames,
        "userId": userId,
        "showImgs": showImgs,
        "topic": topic,
        "great": great,
        "ellipses": ellipses,
      };
}
