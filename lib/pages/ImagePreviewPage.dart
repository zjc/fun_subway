import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/business/p/ImagePreviewPresenter.dart';
import 'package:fun_subway/business/view/ImagePreviewView.dart';
import 'package:fun_subway/widget/photo_view/PhotoView.dart';

class ImagePreviewPage extends StatefulWidget {
  ImageBean imageBean;

  List<ImageBean> imageBeans;

  int mPageSize = 1;
  int currentIndex = 1;

  ImagePreviewPage({this.imageBean, this.imageBeans});

  @override
  State<StatefulWidget> createState() {
    if (imageBeans != null && imageBean != null) {
      for (int i = 0; i < imageBeans.length; i++) {
        ImageBean bean = imageBeans[i];
        if (bean.id == imageBean.id) {
          currentIndex = i + 1;
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
    controller = PageController(initialPage: widget.currentIndex - 1);
  }

  Widget _buildAppBar() {
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(""),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            '${widget.currentIndex}/${widget.mPageSize}',
            style: new TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          actions: <Widget>[
            new Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: new Image.asset(
                "images/ic_image_preview_more.png",
                width: 20.0,
                height: 7.0,
                fit: BoxFit.contain,
              ),
            )
          ],
          backgroundColor: Colors.black,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: new Container(
          color: Colors.black,
          child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new Expanded(
                  flex: 1,
                  child: PageView.builder(
                      itemCount: widget.mPageSize,
                      controller: controller,
                      onPageChanged: onPageChanged,
                      itemBuilder: (context, index) {
                        ImageBean imageBean = widget.imageBeans[index];
                        String displayUrl =
                            ImageBean.getDisplayUrl(true, true, imageBean);
                        return new InkWell(
                          child: new Image.network(
                            displayUrl,
                            fit: BoxFit.contain,
                            width: imageBean.original.width.toDouble(),
                            height: imageBean.original.height.toDouble(),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        );
                        //动图gif没办法播放，滑动卡顿,先废弃
//                    return new PhotoView(
//                      imageProvider: new NetworkImage(displayUrl),
//                      loadingChild: showLoading(),
//                    );
                      }),
                ),
                new Container(
                  padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          new Image.asset(
                            "images/ic_home_collection.png",
                            width: 18.0,
                            height: 17.0,
                            fit: BoxFit.cover,
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 2.5),
                            child: new Text(
                              "收藏",
                              style: new TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      new Column(
                        children: <Widget>[
                          new Image.asset(
                            "images/ic_home_download.png",
                            width: 18.0,
                            height: 17.0,
                            fit: BoxFit.cover,
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 2.5),
                            child: new Text(
                              "下载",
                              style: new TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      new Column(
                        children: <Widget>[
                          new Image.asset(
                            "images/ic_home_share.png",
                            width: 18.0,
                            height: 17.0,
                            fit: BoxFit.cover,
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 2.5),
                            child: new Text(
                              "分享",
                              style: new TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ]),
        ));
  }

  onPageChanged(index) {
    widget.currentIndex = index + 1;
    setState(() {});
  }

  @override
  ImagePreviewPresenter newInstance() {
    return new ImagePreviewPresenter();
  }
}
