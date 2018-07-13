import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/pages/ImagePreviewPage.dart';
import 'package:fun_subway/pages/LoginPage.dart';

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
          return enterByScaleByScreenMiddle(animation, child);
        }));
  }

  static void go2LoginPage(BuildContext context) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return LoginPage();
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return enterFromRight(animation, child);
        }));
  }





  //从屏幕中间放大显示出来，图片点击放大显示
  static enterByScaleByScreenMiddle(Animation<double> animation, Widget child) {
    return new FadeTransition(
      opacity: animation,
      child: new ScaleTransition(
        scale: new Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      ),
    );
  }

  //从右边进入
  static enterFromRight(Animation<double> animation, Widget child) {
    return new FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position:
            new Tween<Offset>(begin: new Offset(1.0, 0.0), end: Offset.zero)
                .animate(animation),
        child: child,
      ),
    );
  }
}
