import 'package:fun_subway/beans/ImageBean.dart';

class ImageTypeFactory {
  static final String WEBP_SUFFIX = ".webp";

  static final String GIF_SUFFIX = ".gif";

  static final String VIDEO_SUFFIX = ".mp4";

  static final String JPEG_SUFFIX = ".jpg";

  /**
   * webp原图Url
   *
   * @param imageBean
   * @return
   */

  static String getOriginalWebp(ImageBean imageBean) {
    return getOriginal(imageBean)
            .resolve("webp")
            .resolve(imageBean.imgName)
            .toString() +
        WEBP_SUFFIX;
  }

  /**
   * gif原图Url
   *
   * @param imageBean
   * @return
   */

  static String getOriginalGif(ImageBean imageBean) {
    String url = getOriginal(imageBean).resolve("original").resolve(imageBean.imgName).toString();
    return url + GIF_SUFFIX;
  }

  /**
   * webp18帧Url
   *
   * @param imageBean
   * @return
   */
  static String getP18Webp(ImageBean imageBean) {
    Uri builder = getDrawing(imageBean);
    if (builder != null) {
      String url =
          builder.resolve("webp18").resolve(imageBean.imgName).toString();
      return url + WEBP_SUFFIX;
    }
    return null;
  }

  /**
   * 18帧gif图Url
   *
   * @param imageBean
   * @return
   */
  String getP18Gif(ImageBean imageBean) {
    Uri builder = getDrawing(imageBean);
    if (builder != null) {
      String url = builder.resolve("p18").resolve(imageBean.imgName).toString();
      return url + GIF_SUFFIX;
    }
    return null;
  }

  /**
   * 1M图Url
   *
   * @param imageBean
   * @return
   */

  static String get1M(ImageBean imageBean) {
    Uri builder = getDrawing(imageBean);
    if (builder != null) {
      String url = builder.resolve("one").resolve(imageBean.imgName).toString();
      return url + GIF_SUFFIX;
    }
    return null;
  }

  /**
   * 2M图Url
   *
   * @param imageBean
   * @return
   */

  static String get2M(ImageBean imageBean) {
    Uri builder = getDrawing(imageBean);
    if (builder != null) {
      return builder.resolve("two").resolve(imageBean.imgName).toString() +
          GIF_SUFFIX;
    }
    return null;
  }

  /**
   * 视频Url
   *
   * @param imageBean
   * @return
   */

  static String getVideo(ImageBean imageBean) {
    Uri builder = getDrawing(imageBean);
    if (builder != null) {
      return builder.resolve("video").resolve(imageBean.imgName).toString() +
          VIDEO_SUFFIX;
    }
    return null;
  }

  /**
   * 首帧图Url
   *
   * @param imageBean
   * @return
   */
  static String getFirstFrame(ImageBean imageBean) {
    Uri builder = getDrawing(imageBean);
    if (builder != null) {
      return builder.resolve("static").resolve(imageBean.imgName).toString() +
          JPEG_SUFFIX;
    }
    return null;
  }

  static Uri getDrawing(ImageBean imageBean) {
    if (imageBean.gif == 1) {
      return getOriginal(imageBean);
    } else
      return null;
  }

  static Uri getOriginal(ImageBean imageBean) {
    return getImageHost().resolve(imageBean.urlPrefix);
  }

  static Uri getImageHost() {
    return Uri.parse("http://image.51biaoqing.com");
  }
}
