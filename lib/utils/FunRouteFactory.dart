import 'package:flutter/material.dart';
import 'package:fun_subway/beans/ImageBean.dart';
import 'package:fun_subway/pages/ImagePreviewPage.dart';

class FunRouteFactory {
  static void go2ImagePreview(
      BuildContext context, ImageBean imageBean, List<ImageBean> imageBeans) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new ImagePreviewPage(
        imageBean: imageBean,
        imageBeans: imageBeans,
      );
    }));
  }
}
