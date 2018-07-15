import 'package:flutter/material.dart';
import 'package:fun_subway/business/beans/HomeBanner.dart';
import 'package:fun_subway/business/beans/MakeOptionBean.dart';
import 'package:fun_subway/business/beans/MakerBean.dart';
import 'package:fun_subway/framework/BaseState.dart';
import 'package:fun_subway/business/p/MakePresenter.dart';
import 'package:fun_subway/business/view/MakeView.dart';
import 'package:fun_subway/utils/FunColors.dart';
import 'package:fun_subway/utils/utils.dart';
import 'package:fun_subway/widget/BannerWidget.dart';

class MakePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MakeState();
  }
}

class MakeState extends BaseState<MakePresenter, MakePage> implements MakeView {
  MakerBean mMakerBean;

  @override
  void initState() {
    super.initState();
    try {
      mPresenter.fetchData();
    } catch (exception) {}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (mMakerBean == null) {
      return showLoading();
    } else {
      return new Container(
          child: new ListView(
        children: <Widget>[_buildBannerWidget(), _buildFunctionWidget()],
      ));
    }
  }

  Widget _buildBannerWidget() {
    List<HomeBanner> entities = mMakerBean.banners;
    double bannerHeight = UIUtils.getScreenWidth(context) / 375.0 * 260.0;
    return new BannerWidget(
      entities: entities,
      height: bannerHeight,
    );
  }

  Widget _buildFunctionWidget() {
    List<MakeOptionBean> makeOptionBeans = mMakerBean.makeOptions;
    if (makeOptionBeans != null && makeOptionBeans.isNotEmpty) {
      //对数据源进行处理，用于后续分页
      int count = makeOptionBeans.length;
      int maxPageCount = 6;
      List<List<MakeOptionBean>> arrayList = [];
      int startIndex = 0;
      while (true) {
        int totalIndex = count - startIndex;
        int lastIndex = Math.min(maxPageCount, totalIndex) + startIndex;
        List<MakeOptionBean> list =
            makeOptionBeans.sublist(startIndex, lastIndex);
        arrayList.add(list);
        startIndex = lastIndex;
        if (startIndex >= count) {
          break;
        }
      }
      double pageHeight = UIUtils.getScreenHeight(context) -
          UIUtils.getScreenWidth(context) / 375.0 * 260.0;
      return new Container(
          height: pageHeight,
          padding: EdgeInsets.only(top: 25.0),
          child: PageView.builder(
              itemCount: arrayList.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                List<MakeOptionBean> childs = arrayList[index];
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0,
                  children: childs.map((makeOptionBean) {
                    return new Column(
                      children: <Widget>[
                        new Image.network(
                          makeOptionBean.icon,
                          width: 85.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        new Text(
                          makeOptionBean.optionName,
                          style: new TextStyle(
                              color: FunColors.c_999, fontSize: 12.0),
                        )
                      ],
                    );
                  }).toList(),
                );
              }));
    }

    return new Container();
  }

  onPageChanged(index) {}

  @override
  MakePresenter newInstance() {
    return MakePresenter();
  }

  @override
  void callback(MakerBean makeBean) {
    this.mMakerBean = makeBean;
    setState(() {});
  }
}
