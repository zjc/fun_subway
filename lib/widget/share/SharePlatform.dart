import 'package:fun_subway/widget/share/SHARE_MEDIA.dart';
import 'package:fun_subway/widget/share/ShareData.dart';

class SharePlatform {
  final String platform; //平台名称，用于显示

  final SHARE_MEDIA platformType; //平台类型，用于程序判断
  final String res; //平台对应的显示icon

  ShareData shareData; //点击需要携带的分享数据

  SharePlatform(this.platform, this.platformType, this.res, {this.shareData});



}

class SharePlatformFactory {
  static List<SharePlatform> defaultSharePlatformFactory() {
    List<SharePlatform> sharePlatforms = [];
    sharePlatforms.add(new SharePlatform(
        "微信", SHARE_MEDIA.WEIXIN, "images/ic_share_wechat.png"));
    sharePlatforms.add(new SharePlatform(
        "朋友圈", SHARE_MEDIA.WEIXIN_CIRCLE, "images/ic_share_wx_friend.png"));
    sharePlatforms
        .add(new SharePlatform("QQ", SHARE_MEDIA.QQ, "images/ic_share_qq.png"));
    sharePlatforms.add(new SharePlatform(
        "qq空间", SHARE_MEDIA.QZONE, "images/ic_share_qq_zone.png"));
    sharePlatforms.add(
        new SharePlatform("微博", SHARE_MEDIA.SINA, "images/ic_share_weibo.png"));
    return sharePlatforms;
  }

  //将平台数据和分享的数据进行绑定，便于后续点击的时候，拿到数据
  static void bindShareDatas(
      List<SharePlatform> platforms, List<ShareData> shareDatas) {
    if (shareDatas == null || shareDatas.isEmpty) {
      return;
    }
    for (SharePlatform platform in platforms) {
      for (ShareData shareData in shareDatas) {
        if (platform.platformType == shareData.platformType) {
          platform.shareData = shareData;
          break;
        }
      }
    }
  }
}
