import 'package:fun_subway/business/beans/BaseBean.dart';
import 'package:fun_subway/business/beans/ImageBean.dart';
import 'package:fun_subway/utils/utils.dart';

class SearchResult extends BaseBean {
  final int total;
  final int pageSize;
  final int page;
  final List<String> topics;
  final String adviceTag;
  final List<ImageBean> rows;
  final List<String> sensitives;

  SearchResult(
      {this.total,
      this.pageSize,
      this.page,
      this.topics,
      this.adviceTag,
      this.rows,
      this.sensitives});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      total: json["total"],
      pageSize: json["pageSize"],
      page: json["page"],
      topics: BaseBean.instanceStringList(json["topics"]),
      adviceTag: json["adviceTag"],
      rows: ImageBean.instanceImageBeans(json["rows"]),
      sensitives: BaseBean.instanceStringList(json["sensitives"]),
    );
  }

  Map<String,dynamic> toJson()=>{
    "total":total,
    "pageSize":pageSize,
    "page":page,
    "topics":topics,
    "adviceTag":adviceTag,
    "rows":rows,
    "sensitives":sensitives,
  };
}
