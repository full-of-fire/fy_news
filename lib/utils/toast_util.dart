import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: Colors.black54,
        fontSize: 20.0);
  }

  static FToast toast = FToast();
  static showLoading(BuildContext context, String message) {
    toast.context = context;
    toast.showToast(
        child: Container(
          width: context.size.width,
          height: context.size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 40.0, 32.0, 24.0),
                  child: Column(
                    children: [CircularProgressIndicator(), SizedBox(height: 16.0), Text(message)],
                  ),
                ),
              )
            ],
          ),
        ),
        gravity: ToastGravity.CENTER,
        toastDuration: Duration(seconds: 30));
  }

  static hide() {
    toast.removeCustomToast();
  }
}
