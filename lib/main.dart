import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/const/strings/FYStrings.dart';
import 'custom_ui/tab_bar_view.dart';
import 'modules/circle/circle.dart';
import 'modules/fyhelp/fy_help.dart';
import 'modules/mine/mine.dart';
import 'modules/news/news.dart';
import 'modules/sameCity/same_city.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabBarView()
    );
  }
}

class TabBarView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _TabBarViewState();
  }
}

class _TabBarViewState extends State<TabBarView> {
  final _defaltColor = FYColors.tab_unSelect_color;
  final _selectColor = FYColors.theme_color;
  final _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          CirclePage(),
          NewsPage(),
          FyHelpPage(),
          MinePage()
        ],
      ),
      bottomNavigationBar: TabNavigationBar(
        items: [
          _barItem(FYStrings.samecity_title, FYStrings.samecity_sel, FYStrings.samecity_nor),
          _barItem(FYStrings.circle_title, FYStrings.circle_sel, FYStrings.circle_nor),
          _barItem(FYStrings.news_title, FYStrings.news_sel, FYStrings.news_nor),
          _barItem(FYStrings.reply_title, FYStrings.reply_sel, FYStrings.reply_nor),
          _barItem(FYStrings.me_title, FYStrings.me_sel, FYStrings.me_nor)
        ],
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _pageController.jumpToPage(index);
            _currentIndex = index;
          });
        },
        selectTextColor: _selectColor,
        unSelectTextColor: _defaltColor,
      )
    );
  }

  // 创建barItem 方法
  TabNavigationBarItem _barItem(String title, String selectImageName, String unSelectImageName) {
    return TabNavigationBarItem(
      title:title,
      selectImage: Image.asset(selectImageName),
      unSelectImage: Image.asset(unSelectImageName)
    );
  }
}