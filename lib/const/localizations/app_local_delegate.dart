import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fy_news/const/localizations/app_localization.dart';

class FYAppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{

  static FYAppLocalizationDelegate delegate = FYAppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["zh","en"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture(AppLocalization(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return false;
  }

}