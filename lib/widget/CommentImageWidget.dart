import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/CommentBean.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/utils/FunRouteFactory.dart';
import 'package:fun_subway/widget/CardImageItem.dart';

class CommentImageWidget extends StatelessWidget {
  CommentBean commentBean;

  bool isNetworkAvailable;
  bool isWifi;

  int paddingSpace;

  CommentImageWidget(this.commentBean, this.paddingSpace,
      {this.isNetworkAvailable = true, this.isWifi = true});

  @override
  Widget build(BuildContext context) {
    if (commentBean.commentImgs == null || commentBean.commentImgs.isEmpty) {
      return new Container();
    }
    return new GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      primary: true,
      physics: ScrollPhysics(),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      children: commentBean.commentImgs.map((ImageBean imageBean) {
        String displayUrl =
            ImageBean.getDisplayUrl(isNetworkAvailable, isWifi, imageBean);
        double itemWidth =
            (MediaQuery.of(context).size.width - paddingSpace) / 3;
        return new InkWell(
          onTap: () {
            FunRouteFactory.go2ImagePreview(
                context, imageBean, commentBean.commentImgs);
          },
          child: new CardImageItem(displayUrl, itemWidth, itemWidth),
        );
      }).toList(),
    );
  }
}
