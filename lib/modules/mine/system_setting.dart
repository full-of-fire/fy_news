
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/app_manager.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/const/localizations/app_local_manager.dart';
import 'package:fy_news/generated/l10n.dart';
import 'package:fy_news/utils/action_sheet_util.dart';
import 'package:fy_news/utils/alert_util.dart';
import 'custom_widgets/system_item.dart';

class SystemSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SystemSettingPageState();
}

class _SystemSettingPageState extends State<SystemSettingPage> {
  String _currentLangue = "中文";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).system_settings,
          style: TextStyle(
            color: FYColors.color_292929,
            fontSize: 18,
          ),
        ),
        toolbarHeight: 44,
        // backgroundColor: Colors.white,
      ),
      body: ListView(
        children: _buildListItems(context),
      )
    );
  }

  List<Widget> _buildListItems(BuildContext context) {
    List<Widget> listItems = [];
    listItems.add(_buildSperateLine());

    final tiltleStyle = TextStyle(
      fontSize: 17,
      color: FYColors.color_292929
    );
    //消息通知
    listItems.add(_buildNormalSettingItem(S.of(context).notification));

    //修改密码
    listItems.add(_buildNormalSettingItem(S.of(context).change_password));

    //清理缓存
    SystemItemWidget clean_up_the = SystemItemWidget(
      title: Text(
        S.of(context).clean_up_the,
        style: tiltleStyle,
      ),
      tail: Text(
        "7.64M"
      ),
      onClick:(){
        _clearCache(context);
      },
    );
    listItems.add(clean_up_the);

    //切换语言
    SystemItemWidget switch_language = SystemItemWidget(
      title: Text(
        S.of(context).switch_language,
        style: tiltleStyle,
      ),
      tail: Text(
          _currentLangue
      ),
      onClick: _onchangeLanguage,
    );
    listItems.add(switch_language);
    listItems.add(_buildSperateLine());
    //关于我们
    listItems.add(_buildNormalSettingItem(S.of(context).about_us));
    listItems.add(_buildNormalSettingItem(S.of(context).privacy_agreement));
    listItems.add(_buildNormalSettingItem(S.of(context).release_agreement));
    return listItems;
  }

  /// 下划线
  Widget _buildSperateLine() {
    return Container(height: 10,color:FYColors.color_f1f0f0);
  }

  /// 普通的设置item
  Widget _buildNormalSettingItem(String title,{VoidCallback onTap}) {
    final tiltleStyle = TextStyle(
        fontSize: 17,
        color: FYColors.color_292929
    );
    return SystemItemWidget(
      title: Text(
        title,
        style: tiltleStyle,
      ),
      onClick: onTap,
    );
  }

  /// 切换语言
  _onchangeLanguage() {
    ActionSheetUtil.showIOSActionSheet(
        actionTitles: ["中文", "English"],
        onItemClick: (index) {
          if (index == 0) {
            AppLocalManager.changeLanguage("zh");
            setState(() {
              _currentLangue = "中文";
            });
          } else {
            AppLocalManager.changeLanguage("en");
            setState(() {
              _currentLangue = "English";
            });
          }
        });
  }

  /// 请除缓存
  _clearCache(BuildContext context) {
    AlertUtil.showAlert(
      title: "清除缓存",
      content: "确认清理缓存吗？",
      onCancel: (){},
      onSure: (){}
    );
  }
}