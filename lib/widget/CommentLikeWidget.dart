import 'package:flutter/material.dart';

class CommentLikeWidget extends StatelessWidget{

  int likeCount;
  bool likeStatue;

  CommentLikeWidget(this.likeCount,this.likeStatue);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text(
          likeCount.toString(),
          style: new TextStyle(
            fontSize: 14.0,
            color: new Color(0xff999999),
          ),
        ),
        new Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: new Image.asset(
            '${
                likeStatue
                    ? "images/ic_home_like2.png"
                    : "images/ic_home_unlike2.png"
            }',
            width: 14.0,
            height: 12.0,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

}