import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/business/beans/HomeBanner.dart';
import 'package:fun_subway/business/beans/MakeOptionBean.dart';

class MakerBean extends BaseBean {
  List<HomeBanner> banners;

  List<MakeOptionBean> makeOptions;

  MakerBean({this.banners, this.makeOptions});

  factory MakerBean.fromJson(Map<String, dynamic> json) {
    return MakerBean(
        banners: HomeBanner.instanceHomeBanners(json["banners"]),
        makeOptions:
            MakeOptionBean.instanceMakeOptionBeans(json["makeOptions"]));
  }

  Map<String, dynamic> toJson() => {
        "banners": banners,
        "makeOptions": makeOptions,
      };
}
