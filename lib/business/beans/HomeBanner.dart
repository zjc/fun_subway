import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/widget/BannerEntity.dart';

class HomeBanner extends BaseBean with BannerEntity {
  final String background; //banner背景图片
  final String url; //执行点击的动作

  HomeBanner({this.background, this.url});

  factory HomeBanner.fromJson(Map<String, dynamic> json) {
    return HomeBanner(background: json["background"], url: json["url"]);
  }

  Map<String, dynamic> toJson() => {
        'background': background,
        'url': url,
      };

  static List<HomeBanner> instanceHomeBanners(List list){
    List<HomeBanner> homeBanners;
    if (list != null && list.isNotEmpty) {
      homeBanners = list.map((map) {
        return HomeBanner.fromJson(map);
      }).toList();
    }
    return homeBanners;

  }

  @override
  get bannerAction => url;

  @override
  get bannerTitle => "123";

  @override
  get bannerUrl => background;
}
