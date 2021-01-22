
import 'package:flutter/widgets.dart';

typedef LocaleValueChange = void Function(Locale);
class AppLocalManager {

  static final List<Locale> supportedLanguages = [
    Locale("en"),
    Locale("zh")
  ];

  static Locale currentLanguage = supportedLanguages.firstWhere((element) => element.languageCode == "zh");
  
  /*改变语言*/
  LocaleValueChange onListValueChange;
  
  static changeLanguage(String langugeCode) {
    Locale locale = AppLocalManager.supportedLanguages.firstWhere((element) => element.languageCode == langugeCode);
    if(locale == null) {
      locale = Locale("zh");
    }
    currentLanguage = locale;
    AppLocalManager.shared.onListValueChange(locale);
  }


  static get shared  => _getInstance();
  static AppLocalManager _manager;
  static AppLocalManager _getInstance() {
    if(_manager == null) {
      _manager = AppLocalManager();
    }
    return _manager;
  }
}