
import 'package:flutter/material.dart';
import 'package:fy_news/const/app_manager.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/const/strings/FYStrings.dart';
import 'package:fy_news/http/Api.dart';
import 'package:fy_news/utils/http_params_util.dart';
import 'package:fy_news/model/config.dart';
import '../custom_ui/tab_bar_view.dart';
import './circle/circle.dart';
import './fyhelp/fy_help.dart';
import './mine/mine.dart';
import './news/news.dart';
import './sameCity/same_city.dart';

class MainRootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabBarViewState();
  }
}

class _TabBarViewState extends State<MainRootPage> {
  final _defaltColor = FYColors.tab_unSelect_color;
  final _selectColor = FYColors.theme_color;
  final _pageController = PageController(initialPage: 0,keepPage: true);
  int _currentIndex = 0;

  @override
  void initState() {
    getConfig();
    super.initState();
  }

  getConfig() async {
    Config config = await Api.user.getConfig();
    print(config.userid);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    HttpParamsUtil.configGlobalContext(context);
    AppManager.shared.globalContext = context;
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