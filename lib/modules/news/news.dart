import 'package:flutter/material.dart';
import 'package:fy_news/const/localizations/app_local_manager.dart';
import 'package:fy_news/generated/l10n.dart' as LocalS;
import 'package:fy_news/modules/news/news_content.dart';
import 'package:fy_news/modules/news/news_search.dart';



class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  PageController _pageController = PageController(initialPage: 1,keepPage: true);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          NewsSearchPage(),
          NewsContentPage(mainPageController: _pageController,)
        ],
      ),
    );
  }
}