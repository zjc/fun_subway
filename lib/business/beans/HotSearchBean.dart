import 'package:fun_subway/business/beans/BaseBean.dart';

class HotSearchBean extends BaseBean {
  final List<String> tags;

  HotSearchBean({this.tags});

  factory HotSearchBean.fromJson(Map<String, dynamic> json) {
    return HotSearchBean(tags: BaseBean.instanceStringList(json["tags"]));
  }

  Map<String, dynamic> toJson() => {
        "tags": tags,
      };
}
