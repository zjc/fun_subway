import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';

class ImageListBean extends BaseBean {
  final int page;
  final int pageSize;
  final int total;
  final List<ImageBean> rows;

  ImageListBean({this.page, this.pageSize, this.total, this.rows});

  factory ImageListBean.fromJson(Map<String, dynamic> json) {
    return ImageListBean(
        page: json["page"],
        pageSize: json["pageSize"],
        total: json["total"],
        rows: ImageBean.instanceImageBeans(json["rows"]));
  }

  Map<String, dynamic> toJson() =>
      {"page": page, "pageSize": pageSize, "total": total, "rows": rows};
}
