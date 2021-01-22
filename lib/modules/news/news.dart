
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/generated/i18n.dart';
import 'package:fy_news/const/localizations/app_local_manager.dart';
import 'package:fy_news/const/localizations/app_localization.dart';
import 'package:fy_news/generated/l10n.dart' as LocalS;


class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(height: 200,),
            Text(LocalS.S.of(context).title),
            FlatButton(onPressed: (){

              print("我被点击了");
              if(AppLocalManager.currentLanguage.languageCode == "zh"){
                AppLocalManager.changeLanguage("en");
              }else {
                AppLocalManager.changeLanguage("zh");
              }


            }, child: Text("点击切换语言"))
          ],
        ),
      ),
    );
  }
}