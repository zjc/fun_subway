import 'package:fun_subway/business/beans/BaseBean.dart';

class ImageOptionsBean extends BaseBean {
  final int frameNum;
  final int height;
  final int size;
  final int width;

  ImageOptionsBean({this.frameNum, this.height, this.size, this.width});

  factory ImageOptionsBean.fromJson(Map<String, dynamic> json) {
    return ImageOptionsBean(
        frameNum: json["frameNum"],
        height: json["height"],
        size: json["size"],
        width: json["width"]);
  }

  Map<String, dynamic> toJson() => {
        "frameNum": frameNum,
        "height": height,
        "size": size,
        "width": width,
      };
}
