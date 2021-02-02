
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/generated/l10n.dart';
import 'package:fy_news/modules/mine/custom_widgets/system_item.dart';

class MsgNoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MsgNoticePageState();
}

class _MsgNoticePageState extends State<MsgNoticePage> {
  @override
  Widget build(BuildContext context) {

    final notices = [
      "全部推送",
      "泛亚资讯",
      "自媒体资讯",
      "评论通知",
      "点赞通知",
      "系统通知",
      "APP内私信推送",
      "离线私信推送"
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        title: Text(S.of(context).notification),
      ),
      body: ListView(
        children: notices.map((e) => _buildMsgNoticeItem(e)).toList(),
      ),
    );
  }


  Widget _buildMsgNoticeItem(String title) {
    return SystemItemWidget(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: FYColors.color_292929
        ),
      ),
      tail: CupertinoSwitch(
        value: true,
      ),
      isShowIndicator: false,
    );
  }
}