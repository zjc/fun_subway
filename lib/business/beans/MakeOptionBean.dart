class MakeOptionBean {
  int deleted;
  String gmtCreate;
  String gmtModified;
  String icon;
  int id;
  String optionName;
  int sortNum;
  String url;

  MakeOptionBean(
      {this.deleted,
      this.gmtCreate,
      this.gmtModified,
      this.icon,
      this.id,
      this.optionName,
      this.sortNum,
      this.url});

  factory MakeOptionBean.fromJson(Map<String, dynamic> map) {
    return new MakeOptionBean(
        deleted: map["deleted"],
        gmtCreate: map["gmtCreate"],
        gmtModified: map["gmtModified"],
        icon: map["icon"],
        id: map["id"],
        optionName: map["optionName"],
        sortNum: map["sortNum"],
        url: map["url"]);
  }

  Map<String, dynamic> toJson() => {
        "deleted": deleted,
        "gmtCreate": gmtCreate,
        "gmtModified": gmtModified,
        "icon": icon,
        "id": id,
        "optionName": optionName,
        "sortNum": sortNum,
        "url": url,
      };

  static List<MakeOptionBean> instanceMakeOptionBeans(List list) {
    List<MakeOptionBean> makeOptionBeans;
    if (list != null && list.isNotEmpty) {
      makeOptionBeans = list.map((map) {
        return MakeOptionBean.fromJson(map);
      }).toList();
    }
    return makeOptionBeans;
  }
}
