import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/business/beans/CommentBean.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/beans/ImageOptionsBean.dart';
import 'package:flutter/material.dart';

class PostBean extends BaseBean {
  String content;
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
      memeImgs: ImageBean.instanceImageBeans(map["memeImgs"]),
      nickname: map["nickname"],
      show: map["show"],
      topicNames: map["topicNames"],
      userId: map["userId"],
      showImgs: ImageBean.instanceImageBeans(map["showImgs"]),
      topic: map["topic"],
      great: CommentBean.fromJson(map["great"]),
      ellipses: map["ellipses"],
    );
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

  //根据图片的数量，返回列的数量
  static int getColumnCount(int size) {
    if (size == 1) {
      return 1;
    }
    if (size == 2 || size == 4) {
      return 2;
    }
    return 3;
  }


  static Size getDisplaySize(
      BuildContext context, int imageCount, ImageBean imageBean) {
    double displayWidth = MediaQuery.of(context).size.width - 20;
    Size size;
    if (imageCount == 1) {
      if (imageBean.isLongImg()) {
        double ratio = 4.0 / 3.0;
        double height = (displayWidth / ratio);
        double width = displayWidth;
        if (height >= displayWidth) {
          height = displayWidth;
          width = height * ratio;
        }
        size = new Size(width, height);
      } else {
        if (imageBean.isGif()) {
          ImageOptionsBean imageOptionsBean = imageBean.original;
          double ratio = imageOptionsBean.width.toDouble() /
              imageOptionsBean.height.toDouble();
          double width = displayWidth;
          double height = (width / ratio);
          size = new Size(width, height);
        } else {
          ImageOptionsBean imageOptionsBean = imageBean.original;
          double ratio = imageOptionsBean.width.toDouble() /
              imageOptionsBean.height.toDouble();
          if (imageOptionsBean.width > imageOptionsBean.height) {
            if (imageOptionsBean.width > displayWidth) {
              size = new Size(displayWidth, displayWidth / ratio);
            } else {
              size = new Size(imageOptionsBean.width.toDouble(),
                  imageOptionsBean.height.toDouble());
            }
          } else {
            if (imageOptionsBean.height > displayWidth) {
              size = new Size(displayWidth * ratio, displayWidth);
            } else {
              size = new Size(imageOptionsBean.width.toDouble(),
                  imageOptionsBean.height.toDouble());
            }
          }
        }
      }
    } else if (imageCount == 2 || imageCount == 4) {
      displayWidth = displayWidth - 3;
      size = new Size(displayWidth / 2, displayWidth / 2);
    } else {
      displayWidth = displayWidth - 3 * 2;
      size = new Size(displayWidth / 3, displayWidth / 3);
    }
    return size;
  }
}
