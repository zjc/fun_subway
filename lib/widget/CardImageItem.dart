import 'package:flutter/material.dart';

//用于图片展示
class CardImageItem extends StatelessWidget {
  String displayUrl;
  double width;
  double height;

  CardImageItem(this.displayUrl, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0))),
      child: new Image.network(
        displayUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}
