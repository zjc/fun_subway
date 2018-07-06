import 'package:fun_subway/beans/BaseBean.dart';
import 'package:fun_subway/beans/ImageOptionsBean.dart';

class ImageBean extends BaseBean {
  static final MAKE = 1;

  static final LOCAL = 2;

  static final REMOTE = 3;

  final int type;

  final int gif; //0 静态图 1:gif图片

  final int id;

  final String imgName;

  final String urlPrefix;

  final ImageOptionsBean original;

  final bool selected;

  final int selectedNum;

  final String number;

  final String absolutelyPath;

  final int placeHolder;

  final int from;

  final int finished; //用于标识其他格式的图片是否都制作完成 0：未完成 1：已完成

  final int imgType; //600用户动态,610相册制图,620模板拼图,630用户评论

  ImageBean(
      {this.type,
      this.gif,
      this.id,
      this.imgName,
      this.urlPrefix,
      this.original,
      this.selected,
      this.selectedNum,
      this.number,
      this.absolutelyPath,
      this.placeHolder,
      this.from,
      this.finished,
      this.imgType});

  factory ImageBean.fromJson(Map<String, dynamic> map) {
    return ImageBean(
      type: map["type"],
      gif: map["gif"],
      id: map["id"],
      imgName: map["imgName"],
      urlPrefix: map["urlPrefix"],
      original: ImageOptionsBean.fromJson(map["original"]),
      selected: map["selected"],
      selectedNum: map["selectedNum"],
      number: map["number"],
      absolutelyPath: map["absolutelyPath"],
      placeHolder: map["placeHolder"],
      from: map["from"],
      finished: map["finished"],
      imgType: map["imgType"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "gif": gif,
        "id": id,
        "imgName": imgName,
        "urlPrefix": urlPrefix,
        "original": original,
        "selected": selected,
        "selectedNum": selectedNum,
        "number": number,
        "absolutelyPath": absolutelyPath,
        "placeHolder":placeHolder,
        "from": from,
        "finished": finished,
        "imgType": imgType,
      };
}
