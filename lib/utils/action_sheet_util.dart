import 'package:flutter/cupertino.dart';
import 'package:fy_news/generated/l10n.dart';
import 'package:fy_news/const/app_manager.dart';

typedef ActionSheetItemClick = void Function(int);
class ActionSheetUtil {
  /// 显示iOS风格的弹窗
  static showIOSActionSheet(
      {@required List<String> actionTitles,
      onItemClick: ActionSheetItemClick}) {
    BuildContext context = AppManager.shared.globalContext;
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          List<Widget> actions = [];
          for (int i = 0; i < actionTitles.length; i++) {
            actions.add(CupertinoActionSheetAction(
              onPressed: () {
                if (onItemClick != null) {
                  onItemClick(i);
                }
                Navigator.pop(context);
              },
              child: Text(actionTitles[i]),
            ));
          }

          return CupertinoActionSheet(
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancel),
            ),
          );
        });
  }
}