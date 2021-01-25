import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fy_news/modules/news/news_list.dart';

///https://juejin.cn/post/6900751363173515278
class NewsContentPage extends StatefulWidget {
  const NewsContentPage({this.mainPageController});
  ///主控制器
  final PageController mainPageController;
  @override
  State<StatefulWidget> createState() => _NewsContentPageState();
}

class _NewsContentPageState extends State<NewsContentPage> with  SingleTickerProviderStateMixin{
  TabController _tabController;
  ScrollController _currentMainScrollController = ScrollController(initialScrollOffset: 44);
  DragStartDetails _dragStartDetails;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 12, vsync: this);
    _tabController.addListener(() {
      _tabController.index;
    });

    _currentMainScrollController.addListener(() {

      print(_currentMainScrollController.position.pixels);

    });

    super.initState();

  }
  @override
  void dispose() {
    _tabController.removeListener(() { });
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        color: Colors.green,
        margin: EdgeInsets.only(top: top),
        child: _contentScrollView()
      )
    );
  }

  /*滚动内容视图*/
  Widget _contentScrollView() {
    return CustomScrollView(
      controller: _currentMainScrollController,
      slivers: [
        _buildTopSearchBar(),
        _buildTopTabBarView(),
        _buildTabBarContentView()
      ],
    );
  }

  Widget _buildTopSearchBar() {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        minHeight: 44,
        maxHeight: 44,
        child: Container(
          color: Colors.blue,
        )
      ),
    );
  }

  Widget _buildTopTabBarView() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 44,
        maxHeight: 44,
        child: _buildTopTabBar()
      )
    );
  }


  /*顶部*/
  Widget _buildTopTabBar() {
    return Row(
      children: [
        Expanded(
          child: NotificationListener(
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                Tab(text: "热点",),
                Tab(text: "时政",),
                Tab(text: "经济",),
                Tab(text: "社会",),
                Tab(text: "生活",),
                Tab(text: "东南亚",),
                Tab(text: "热点",),
                Tab(text: "时政",),
                Tab(text: "经济",),
                Tab(text: "社会",),
                Tab(text: "生活",),
                Tab(text: "东南亚",)
              ],
            ),
            onNotification: _handleNotice,
          ),
        ),
        Container(
          width: 44,
          color: Colors.deepOrange,
        )
      ],
    );
  }

  Widget _buildTabBarContentView() {
    return SliverFillRemaining(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: NotificationListener(
            child: TabBarView(
              controller: _tabController,
              children: _buildNewsListViews(),
            ),
            onNotification: _handleNotice,
          )
      )
    );
  }

  List<Widget> _buildNewsListViews() {

    List<Widget> contents = [];
    for( int i = 0; i < _tabController.length; i++) {
      contents.add(
        NewsListPage(
          listScrollDirectonValueChange: (scrollDirect){
            if(scrollDirect == ListScrollDirection.up) {
              _currentMainScrollController.position.animateTo(44,duration: Duration(microseconds: 250),curve: Curves.linear);
            }else {
              _currentMainScrollController.position.animateTo(0,duration: Duration(microseconds: 250),curve: Curves.linear);
            }
          },
        )
      );
    }
    return contents;
  }
  /// 处理滚动通知
  bool _handleNotice(Notification notification) {
    if(notification is ScrollStartNotification) {
      _dragStartDetails = notification.dragDetails;
    }

    if (notification is UserScrollNotification &&
        notification.direction == ScrollDirection.forward &&
        !_tabController.indexIsChanging &&
        _dragStartDetails != null &&
        _tabController.index == 0) {
      widget.mainPageController.position.drag(_dragStartDetails, () {});
    }

    return true;
  }

}

class NewsContentScrollController extends ScrollController {

}



// SliverPersistentHeaderDelegate 的实现类
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {

  const _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child
  });

  final Widget child;
  final double minHeight;
  final double maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => this.maxHeight;

  @override
  double get minExtent => this.minHeight;

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
