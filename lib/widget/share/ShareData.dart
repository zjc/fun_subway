import 'package:fun_subway/widget/share/SHARE_MEDIA.dart';

abstract class ShareData {
  final ShareType shareType; //分享类型

  final SHARE_MEDIA platformType; //平台类型

  ShareData(this.shareType, this.platformType, {this.shareSource});

  final int shareSource; //分享来源，用于数据统计打点,可有可无

  Map<String, dynamic> toJson() {
    return {
      "shareType": shareType,
      "platformType": platformType,
      "shareSource": shareSource
    };
  }
}

//分享出去成web可点击的卡片样式
class ShareDataWeb extends ShareData {
  final String picUrl;
  final String title;
  final String desc;
  final String targetUrl;

  ShareDataWeb(this.picUrl, this.title, this.desc, this.targetUrl,
      SHARE_MEDIA platformType,
      {int shareSource})
      : super(ShareType.SHARE_TYPE_WEB, platformType, shareSource: shareSource);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superJson = super.toJson();
    Map<String, dynamic> childJson = {
      "title": title,
      "picUrl": picUrl,
      "desc": desc,
      "targetUrl": targetUrl
    };
    childJson.addAll(superJson);

    return childJson;
  }
}

//分享出去成为表情
class ShareDataEmoji extends ShareData {
  final String url; //原始gif图片
  final String thumbUrl; //gif第一帧
  ShareDataEmoji(this.url, this.thumbUrl, SHARE_MEDIA platformType,
      {int shareSource})
      : super(ShareType.SHARE_TYPE_EMOJI, platformType,
            shareSource: shareSource);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superJson = super.toJson();
    Map<String, dynamic> childJson = {
      "url": url,
      "thumbUrl": thumbUrl,
    };
    childJson.addAll(superJson);
    return childJson;
  }
}

//分享出去单张图片
class ShareDataImage extends ShareData {
  final String url;

  ShareDataImage(this.url, SHARE_MEDIA platformType)
      : super(ShareType.SHARE_TYPE_IMAGE_URL, platformType);

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superJson = super.toJson();
    Map<String, dynamic> childJson = {
      "url": url,
    };
    childJson.addAll(superJson);
    return childJson;
  }
}
