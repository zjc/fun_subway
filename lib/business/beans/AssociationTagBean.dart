import 'package:fun_subway/business/beans/BaseBean.dart';

class AssociationTagBean extends BaseBean {
  final List<String> tags;

  AssociationTagBean({this.tags});

  factory AssociationTagBean.fromJson(Map<String, dynamic> json) {
    return AssociationTagBean(tags: BaseBean.instanceStringList(json["tags"]));
  }

  Map<String, dynamic> toJson() => {
        "tags": tags,
      };
}
