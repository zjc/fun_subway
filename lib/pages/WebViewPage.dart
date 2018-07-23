import 'package:flutter/material.dart';
import 'package:fun_subway/plugins/webview/webview_scaffold.dart';

import 'package:fun_subway/utils/FunColors.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String url;
  bool isShowAppBar;

  WebViewPage(this.url, {this.title = "网页", this.isShowAppBar = true});

  @override
  State<StatefulWidget> createState() {
    return new WebViewState();
  }
}

class WebViewState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.isShowAppBar) {
      return new WebviewScaffold(
        url: widget.url,
        appBar: new AppBar(
          title: new Text(
            widget.title,
            style: new TextStyle(color: FunColors.c_333, fontSize: 18.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.black87),
        ),
        withZoom: false,
        withLocalStorage: true,
      );
    } else {
      return new Scaffold(
        body: new Container(
          padding: const EdgeInsets.only(top: 30.0),
          child: new WebviewScaffold(
            url: widget.url,
          ),
        ),
      );
    }
  }
}
