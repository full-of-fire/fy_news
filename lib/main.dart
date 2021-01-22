import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/utils/http_params_util.dart';
import 'modules/main_root.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainRootPage()
    );
  }
}

