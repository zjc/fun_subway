import 'package:flutter/material.dart';
import 'package:fun_subway/beans/ImageBean.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/p/ImagePreviewPresenter.dart';
import 'package:fun_subway/view/ImagePreviewView.dart';
import 'package:fun_subway/widget/photo_view/PhotoView.dart';

int mPageSize = 1;
int currentIndex = 1;

class ImagePreviewPage extends StatefulWidget {
  ImageBean imageBean;

  List<ImageBean> imageBeans;

  ImagePreviewPage({this.imageBean, this.imageBeans});

  @override
  State<StatefulWidget> createState() {
    if (imageBeans != null && imageBean != null) {
      for (int i = 0; i < imageBeans.length; i++) {
        ImageBean bean = imageBeans[i];
        if (bean.id == imageBean.id) {
          currentIndex = i;
          break;
        }
      }
      mPageSize = imageBeans.length;
    }
    return ImagePreviewState();
  }
}

class ImagePreviewState
    extends BaseState<ImagePreviewPresenter, ImagePreviewPage>
    implements ImagePreviewView {
  PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentIndex.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Image.asset(
              "images/ic_white_left_arrow.png",
              width: 8.0,
              height: 14.0,
              fit: BoxFit.cover,
            ),
            new Text('${currentIndex}/${mPageSize}'),
            new Image.asset(
              "images/ic_image_preview_more.png",
              width: 18.0,
              height: 5.0,
              fit: BoxFit.cover,
            )
          ],
        ),
        PageView.builder(
            itemCount: mPageSize,
            controller: controller,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              String displayUrl =
                  ImageBean.getDisplayUrl(true, true, widget.imageBeans[index]);
              return new PhotoView(
                imageProvider: new NetworkImage(displayUrl),
                loadingChild: showLoading(),
              );
            }),
      ],
    );
  }

  onPageChanged(index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  ImagePreviewPresenter newInstance() {
    return new ImagePreviewPresenter();
  }
}
