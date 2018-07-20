import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/business/p/ProductPresenter.dart';
import 'package:fun_subway/business/view/ImageBeanView.dart';
import 'package:fun_subway/framework/LoadMoreState.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/utils.dart';

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProductState();
  }
}

class ProductState extends LoadMoreState<ProductPresenter, ProductPage>
    implements ImageBeanView {
  bool isEditModel = false; //是否编辑模式
  @override
  void initState() {
    super.initState();
    mPresenter.fetchData();
  }

  List<int> _selectImageBeans = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: defaultAppBar("我的作品", [
        new InkWell(
          onTap: () {
            setState(() {
              isEditModel = !isEditModel;
            });
          },
          child: new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 15.0, left: 15.0),
            child: new Text(
              "编辑",
              style: new TextStyle(color: FunColors.c_333, fontSize: 16.0),
            ),
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
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          childAspectRatio: 1.0,
          children: _dataSource.map((imageBean) {
            double width = (UIUtils.getScreenWidth(context) - 16.0) / 3;
            String displayUrl =
                ImageBean.getDisplayUrl(isNetworkAvailable, isWifi, imageBean);
            return new Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                buildCardImageItem(displayUrl, width, width),
                new Container(
                  color: isEditModel ? new Color(0x7fffffff): Colors.transparent,
                ),
                _buildSelector(imageBean),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSelector(ImageBean imageBean) {
    if (isEditModel) {
      if (_selectImageBeans.contains(imageBean.id)) {
        return new Container(
          margin: EdgeInsets.only(right: 5.0, top: 5.0),
          child: new Image.asset(
            "images/ic_image_selected.png",
            width: 30.0,
            height: 30.0,
            fit: BoxFit.contain,
          ),
        );
      } else {
        return new Container(
          margin: EdgeInsets.only(right: 5.0, top: 5.0),
          child: new Image.asset(
            "images/ic_image_unselected.png",
            width: 30.0,
            height: 30.0,
            fit: BoxFit.contain,
          ),
        );
      }
    } else {
      return new Container();
    }
  }

  @override
  ProductPresenter newInstance() {
    return new ProductPresenter();
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
