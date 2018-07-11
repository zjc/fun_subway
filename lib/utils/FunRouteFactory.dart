import 'package:flutter/material.dart';
import 'package:fun_subway/beans/ImageBean.dart';
import 'package:fun_subway/pages/ImagePreviewPage.dart';

class FunRouteFactory {
  static void go2ImagePreview(
      BuildContext context, ImageBean imageBean, List<ImageBean> imageBeans) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ImagePreviewPage(
            imageBean: imageBean,
            imageBeans: imageBeans,
          );
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new ScaleTransition(
              scale: new Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }
}
