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
    StringBuffer sb =
        append(append(getOriginal(imageBean), "webp"), imageBean.imgName);
    sb.write(WEBP_SUFFIX);
    return sb.toString();
  }

  /**
   * gif原图Url
   *
   * @param imageBean
   * @return
   */

  static String getOriginalGif(ImageBean imageBean) {
    StringBuffer sb =
        append(append(getOriginal(imageBean), "original/"), imageBean.imgName);
    sb.write(GIF_SUFFIX);
    return sb.toString();
  }

  /**
   * webp18帧Url
   *
   * @param imageBean
   * @return
   */
  static String getP18Webp(ImageBean imageBean) {
    StringBuffer builder = getDrawing(imageBean);
    if (builder != null) {
      builder = append(append(builder, "webp18"), imageBean.imgName);
      builder.write(WEBP_SUFFIX);
      return builder.toString();
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
    StringBuffer builder = getDrawing(imageBean);
    if (builder != null) {
      builder = append(append(builder, "p18"), imageBean.imgName);
      builder.write(GIF_SUFFIX);
      return builder.toString();
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
    StringBuffer builder = getDrawing(imageBean);
    if (builder != null) {
      builder = append(append(builder, "one"), imageBean.imgName);
      builder.write(GIF_SUFFIX);
      return builder.toString();
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
    StringBuffer builder = getDrawing(imageBean);
    if (builder != null) {
      builder = append(append(builder, "two"), imageBean.imgName);
      builder.write(GIF_SUFFIX);
      return builder.toString();
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
    StringBuffer builder = getDrawing(imageBean);
    if (builder != null) {
      builder = append(append(builder, "video"), imageBean.imgName);
      builder.write(VIDEO_SUFFIX);
      return builder.toString();
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
    StringBuffer buffer = getDrawing(imageBean);
    if (buffer != null) {
      buffer = append(append(buffer, "static"), imageBean.imgName);
      buffer.write(JPEG_SUFFIX);
      return buffer.toString();
    }
    return null;
  }

  static StringBuffer append(StringBuffer old, String path) {
    old.write(path);
    return old;
  }

  static StringBuffer getDrawing(ImageBean imageBean) {
    if (imageBean.gif == 1) {
      return getOriginal(imageBean);
    } else
      return null;
  }

  static StringBuffer getOriginal(ImageBean imageBean) {
    String urlPrefix = imageBean.urlPrefix;
    StringBuffer sb = getImageHost();
    if (!urlPrefix.startsWith("/")) {
      sb.write("/");
    }
    sb.write(urlPrefix);
    return sb;
  }

  static StringBuffer getImageHost() {
    return new StringBuffer("http://image.51biaoqing.com");
  }
}
