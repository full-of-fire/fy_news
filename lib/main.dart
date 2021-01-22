import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fy_news/const/localizations/app_local_delegate.dart';
import 'package:fy_news/const/localizations/app_local_manager.dart';
import 'generated/l10n.dart';
import 'modules/main_root.dart';


void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LocalApp();
  }
}

class LocalApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocalAppState();
}

class _LocalAppState extends State<LocalApp> {

  @override
  void initState() {
    AppLocalManager.shared.onListValueChange = (Locale locale) {
      setState(() {
        print("我要更新语言");
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
          GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
          GlobalWidgetsLocalizations.delegate, // 指定默认的文本排列方向, 由左到右或由右到左,
          FYAppLocalizationDelegate.delegate,   // 自定义的
          S.delegate
        ],
        locale: AppLocalManager.currentLanguage,
        supportedLocales: AppLocalManager.supportedLanguages,
        home: MainRootPage()
    );
  }
}

