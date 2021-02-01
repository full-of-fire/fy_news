import 'package:flutter/cupertino.dart';
import 'package:fy_news/const/app_manager.dart';
import 'package:fy_news/generated/l10n.dart';
class AlertUtil {

  /// 显示iOS风格弹窗
  static showAlert(
      {@required String title,
      @required String content,
      onSure: VoidCallback,
      onCancel: VoidCallback}) {
    BuildContext context = AppManager.shared.globalContext;
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                onPressed: (){
                  if(onCancel != null) {
                    onCancel();
                  }
                  Navigator.pop(context);
                },
                child: Text(S.of(context).cancel),
              ),
              CupertinoDialogAction(
                onPressed: (){
                  if(onSure != null) {
                    onSure();
                  }
                  Navigator.pop(context);
                },
                child: Text(S.of(context).confirm),
              ),
            ],
          );
        });
  }
}