
import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/const/strings/FYStrings.dart';
import 'package:fy_news/generated/l10n.dart';
import 'package:fy_news/modules/mine/system_setting.dart';
import 'package:fy_news/utils/navigator_util.dart';


class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
          color: FYColors.color_f7f7f7,
          child: ListView(
            children: _buildListViewItems(context),
          ),
        )
      )
    );
  }
  
  /// ListView列表
  List<Widget> _buildListViewItems(BuildContext context) {
    List<Widget> listItems = [];
    listItems.add(_buildHeaderView());
    listItems.add(_buildMineOperateContentView(context));
    listItems.addAll(_buildSettingItems(context));
    return listItems;
  } 

  /// headerView
  Widget _buildHeaderView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final top = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Container(
          height: 189+top,
          width: screenWidth,
          child: Image.asset(FYStrings.mine_bg,fit: BoxFit.fill,),
        ),
        _buildUserInfoView(context)
      ],
    );
  }
  /// 用户信息view
  Widget _buildUserInfoView(BuildContext context) {
    final marign_top = MediaQuery.of(context).padding.top + 45;
    final  double infoHeight = 144;
    return _BorderWithShadowView(
      height: infoHeight,
      marign: EdgeInsets.only(top: marign_top,left: 15,right: 15),
      child: Column(
        children: [
          //顶部用户信息view
          _buildTopUserInfoView(context),
          //底部用户信息view
          _buildBottomUserInfoView(context)
        ],
      ),
    );
  }

  /// 用户顶部view
  Widget _buildTopUserInfoView(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.amber,
        child: Row(
          children: [
            _buildTopAvatar(),
            _buildToCenterContentView(context),
            _buildTopRightTitleItem(context)
          ],
        ),
      ),
    );
  }
  /// 用户头像
  Widget _buildTopAvatar() {
    final double imageWidth = 60;
    return GestureDetector(
      onTap: (){
        print("头像被点击了");
      },
      child:Container(
        width: imageWidth,
        height: imageWidth,
        margin: EdgeInsets.only(left: 12,right: 15),
        child:  CircleAvatar(
          child: Image.asset(FYStrings.mine_defalut_avatar,)
        ),
      )
    );
  }

  /// 顶部中间view
  Widget _buildToCenterContentView(BuildContext context) {
    final double height = 60;
    return Expanded(
      child: Container(
        height: height,
        // color: Colors.blue,
        child: _buildLoginedView(context),
      ),
    );
  }
  
  /// 未登录视图
  Widget _buildUnLoginView(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("跳转到登录页面");
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).login_or_register,
            style: TextStyle(
              fontSize: 15,
              color: FYColors.color_292929
            ),
          )
        ],
      ),
    );
  }
  /// 已经登录的view
  Widget _buildLoginedView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "周杰伦",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: FYColors.color_292929
          ),
        ),
        Text(
          "歌手",
          style: TextStyle(
            fontSize: 13,
            color: FYColors.color_292929
          ),
        )
      ],
    );
  }


  /// 个人中心
  Widget _buildTopRightTitleItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("个人中心");
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        child: Row(children: [
          Text(S.of(context).my_home_page),
          Image.asset(FYStrings.mine_right_arrow)
        ]),
      ),
    );
  }

  ///用户底部view
  Widget _buildBottomUserInfoView(BuildContext context) {
    final titles = [
      {
        "title": S.of(context).publish,
        "count": 1,
        "index": 0
      },
      {
        "title": S.of(context).follow,
        "count": 2,
        "index": 1
      },
      {
        "title": S.of(context).fan,
        "count": 3,
        "index": 2
      },
      {
        "title": S.of(context).praise,
        "count": 5,
        "index": 3
      }
    ];
    return Container(
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: titles.map((e) => _buildBottomTitleItem(e)).toList(),
      ),
    );
  }

  Widget _buildBottomTitleItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: (){
        _onclickBottomTitleItem(item);
      },
      child: Column(
        children: [
          Text(
            item["title"],
            style: TextStyle(
                color: Colors.black,
                fontSize: 16
            ),
          ),

          Text(
            "${item["count"]}",
            style: TextStyle(
                color: FYColors.mine_a8a8a8,
                fontSize: 12
            ),
          )
        ],
      ),
    );
  }
  
  /// 我的操作容器
  Widget _buildMineOperateContentView(BuildContext context) {

    final operateItems = [
      {
        "title": S.of(context).my_collection,
        "image_path": FYStrings.mine_favorite
      },
      {
        "title": S.of(context).my_comment,
        "image_path": FYStrings.mine_comment
      },
      {
        "title": S.of(context).browsing_history,
        "image_path": FYStrings.mine_history
      }
    ];
    return _BorderWithShadowView(
      height: 77,
      marign: EdgeInsets.only(left: 15,right: 15,top: 10) ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: operateItems.map((e) => _buildOperateItem(e)).toList(),
      ),
    );
  }

  /// 操作的item
  Widget _buildOperateItem(Map<String,String> item) {
    return GestureDetector(
      onTap: (){
        print(item["title"]);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Image.asset(item["image_path"]),
          ),
          Text(
            item["title"]
          )
        ],
      ),
    );
  }

  /// 设置列表
  List<Widget> _buildSettingItems(BuildContext context) {
    List<_MineConfigItem> items = [];

    //反馈
    _MineConfigItem feedbackItem = _MineConfigItem(
      title: S.of(context).feedback,
      icon: FYStrings.mine_feedback,
    );
    items.add(feedbackItem);
    //设置
    _MineConfigItem configItem = _MineConfigItem(
      title: S.of(context).setting,
      icon: FYStrings.mine_setting,
      onClick: (){
        NavigatorUtil.push(page: SystemSettingPage());
      }
    );
    items.add(configItem);

    return items.map((e) => _buildSettingItem(e)).toList();
  }

  /// 设置item
  Widget _buildSettingItem(_MineConfigItem item) {
    return GestureDetector(
      onTap: item.onClick,
      child: _BorderWithShadowView(
        height: 52,
        marign: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Row(
          children: [
            Container(
              child: Image.asset(item.icon),
              margin: EdgeInsets.only(left: 15,right: 15),
            ),
            Text(item.title),
            Spacer(),
            Container(
              child: Image.asset(FYStrings.mine_right_arrow),
              margin: EdgeInsets.only(right: 15),
            )
          ],
        ),
      ),
    );
  }

  /// 底部四个点击事件
  _onclickBottomTitleItem(Map<String,dynamic> item) {
    print(item["title"]);
  }
}



/// 圆角和阴影容器
class _BorderWithShadowView extends StatelessWidget {
  const _BorderWithShadowView({this.child,this.height,this.marign});
  final Widget child;
  final double height;
  final EdgeInsets marign;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: FYColors.mine_shadow_color.withOpacity(0.6),
                offset: Offset(0.0,2.0),
                blurRadius: 2
            )
          ]
      ),
      child: this.child,
      height: height,
      margin: marign,

    );
  }
}


/// 设置item
class _MineConfigItem {
  const _MineConfigItem({this.icon,this.title,this.onClick});
  final String icon;
  final String title;
  final VoidCallback onClick;
}