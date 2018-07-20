import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/p/CollectionPresenter.dart';
import 'package:fun_subway/business/p/ProductPresenter.dart';
import 'package:fun_subway/business/view/ImageBeanView.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/utils.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CollectionState();
  }
}

class CollectionState extends LoadMoreState<CollectionPresenter, CollectionPage>
    implements ImageBeanView {
  @override
  void initState() {
    super.initState();
    mPresenter.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: defaultAppBar("我的收藏", [
        new InkWell(
          onTap: () {},
          child: new Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: new Text("编辑"),
          ),
        )
      ]),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new ListView(
      scrollDirection: Axis.vertical,
      controller: mScrollController,
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      children: [
        GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          childAspectRatio: 1.0,
          shrinkWrap:true,
          scrollDirection: Axis.vertical,
          children: _dataSource.map((imageBean) {
            String displayUrl =
                ImageBean.getDisplayUrl(isNetworkAvailable, isWifi, imageBean);
            double width = (UIUtils.getScreenWidth(context) - 16.0) / 3;
            return buildCardImageItem(displayUrl, width, width);
          }).toList(),
        ),
      ],
    );
  }

  @override
  CollectionPresenter newInstance() {
    return new CollectionPresenter();
  }

  List<ImageBean> _dataSource = [];

  @override
  void updateList(List<ImageBean> images) {
    if (images != null && images.isNotEmpty) {
      setState(() {
        _dataSource.addAll(images);
      });
    } else {
      showToast("没有更多的数据展示");
    }
  }
}
