import 'package:fun_subway/beans/BaseBean.dart';
import 'package:fun_subway/beans/ImageBean.dart';

class CommentBean extends BaseBean {
  final String profilePicture;

  final int targetId;

  final String imageUrls;

  final String nickname;

  final int likeCount;

  final bool likeStatus;

  final int id;

  final int postId;

  final int gmtCreate;

  final int userId;

  String content;

  final int replyCount;

  final String lastReplyNickname;

  final int lastReplyUserId;

  final String replyNickname;

  final int replyUserId;

  final String commentCode;

  final List<ImageBean> commentImgs; //评论图片对象列表

  CommentBean(
      {this.profilePicture,
      this.targetId,
      this.imageUrls,
      this.nickname,
      this.likeCount,
      this.likeStatus,
      this.id,
      this.postId,
      this.gmtCreate,
      this.userId,
      this.content,
      this.replyCount,
      this.lastReplyNickname,
      this.lastReplyUserId,
      this.replyNickname,
      this.replyUserId,
      this.commentCode,
      this.commentImgs});

  factory CommentBean.fromJson(Map<String, dynamic> json) {
    return CommentBean(
      profilePicture: json["profilePicture"],
      targetId: json["targetId"],
      imageUrls: json["imageUrls"],
      nickname: json["nickname"],
      likeCount: json["likeCount"],
      likeStatus: json["likeStatus"],
      id: json["id"],
      postId: json["postId"],
      gmtCreate: json["gmtCreate"],
      userId: json["userId"],
      content: json["content"],
      replyCount: json["replyCount"],
      lastReplyNickname: json["lastReplyNickname"],
      lastReplyUserId: json["lastReplyUserId"],
      replyNickname: json["replyNickname"],
      replyUserId: json["replyUserId"],
      commentCode: json["commentCode"],
      commentImgs: ImageBean.instanceImageBeans(json["commentImgs"]),
    );
  }

  Map<String,dynamic> toJson()=>{
    "profilePicture":profilePicture,
    "targetId":targetId,
    "imageUrls":imageUrls,
    "nickname":nickname,
    "likeCount":likeCount,
    "likeStatus":likeStatus,
    "id":id,
    "postId":postId,
    "gmtCreate":gmtCreate,
    "userId":userId,
    "content":content,
    "replyCount":replyCount,
    "lastReplyNickname":lastReplyNickname,
    "lastReplyUserId":lastReplyUserId,
    "replyNickname":replyNickname,
    "replyUserId":replyUserId,
    "commentCode":commentCode,
    "commentImgs":commentImgs,
  };
}
