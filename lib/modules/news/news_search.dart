import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NewsSearchPage extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("搜索页面"),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("搜索页面销毁");
    super.dispose();
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}