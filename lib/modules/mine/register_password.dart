
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/custom_ui/custom_app_bar.dart';
import 'package:fy_news/custom_ui/mine_text_field.dart';
import 'package:fy_news/generated/l10n.dart';
import 'package:fy_news/http/Api.dart';
import 'dart:async';

import 'package:fy_news/utils/toast_util.dart';

class RegisterPasswordPage extends StatefulWidget {
  RegisterPasswordPage({
    this.moblie,
    this.moblieCode
  });
  /// 手机号
  final String moblie;
  /// 手机区号
  final String moblieCode;
  @override
  State<StatefulWidget> createState() => _RegisterPasswordState();
}

class _RegisterPasswordState extends State<RegisterPasswordPage> {
 
  /// 是否显示下一步
  bool enableNextStep = false;
  /// 是否有验证码
  bool _hasVerifyCode = false;
  /// 是否有密码
  bool _hasPassword = false;
  /// 验证码
  String _verifyCode;
  /// 密码
  String _password;

  Timer _timer;
  int _countdownTime = 0;

  TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
  @override
  void initState() {
    super.initState();
    tapGestureRecognizer.onTap = (){
      Navigator.pop(context);
    };
  }

  @override
  void dispose() {
    super.dispose();
    if(_timer != null) {
      _timer.cancel();
    }
  }


  /// 注册
  _nextStepTap() async {
    try {
      Map userInfo = await Api.user.phoneRegister(moblieCode: widget.moblieCode,mobile: widget.moblie,verfiyCode: _verifyCode,password: _password);
    }catch(e) {
      ToastUtil.showToast(e.toString());
    }
  }

  /// 开启定时器
  _startTimedonwTimer() async {
    //1.发送验证码如果成功就开始倒计时
    Map ret =  await Api.user.sendVerifyCode(moblieCode: widget.moblieCode,mobile: widget.moblie);
    if(ret != null) {
      ToastUtil.showToast("发送成功");
    }else {
      ToastUtil.showToast("发送失败");
      return;
    }
    //2.开始倒计时
    setState(() {
      _countdownTime = 60;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_countdownTime < 1) {
          _timer.cancel();
        }else {
          _countdownTime -= 1;
        }
      });
    });
  }

  /// 验证码
  _verifyCodeChanged(String text) {
    _verifyCode = text;
  }

  _hasVerifyCodeTextChanged(bool hasText) {
    _hasVerifyCode = hasText;
    _checkNextButtonEnable();
  }

  /// 验证码
  _passwordChanged(String text) {
    _password = text;
  }

  _passwordTextChanged(bool hasText) {
    _hasPassword = hasText;
    _checkNextButtonEnable();
  }


  _checkNextButtonEnable() {
    if(_hasPassword && _hasVerifyCode) {
      setState(() {
        enableNextStep = true;
      });
    }else {
      setState(() {
        enableNextStep = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                _buildTitleView(context),
                // 输入框
                _buildInputView(context),
                // 注册提示
                // _buildRegistTipsView(context),
                // 下一步
                _buildNextStepButton(context),
                // 用户协议
                _buildRegisterUserProtocol(context)

              ],
            ),
          ),
        ));
  }

  /// 顶部标题
  Widget _buildTitleView(BuildContext context) {
    List<Widget> items = List();
    items.add(Text(
      S.of(context).mobile_number_registration,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ));
    items.add(_buildAccontExistTipsView(context));
    return Column(
      children: items,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }


  /// 账号存在提示view
  Widget _buildAccontExistTipsView(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: widget.moblieCode + " " + widget.moblie,
          style: TextStyle(
              color: FYColors.color_292929,
              fontSize: 13
          ),
          children: [
            TextSpan(
                text: "更换账号",
                style: TextStyle(
                  fontSize: 13,
                  color: FYColors.theme_color,
                ),
                recognizer: tapGestureRecognizer
            )
          ]
      ),
    );
  }


  /// 输入view
  Widget _buildInputView(BuildContext context) {
    return Column(
      children: [
        _buildVerifyCodeInputView(context),
        _buildPasswordInputView(context)
      ],
    );
  }

  /// 验证码输入框
  Widget _buildVerifyCodeInputView(BuildContext context) {
    return Container(
        height: 60,
        margin: EdgeInsets.only(top: 45),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                      height: 59,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MineTextField(placeHolderText: "输入验证码",onChanged: _verifyCodeChanged,
                            hasTextChanged: _hasVerifyCodeTextChanged,),
                        ],
                      )
                  ),
                ),
                Container(
                  height: 59,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCountdownText(context)
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              color: FYColors.color_f1f0f0,
            )
          ],
        )
    );
  }




  /// 密码输入框
  Widget _buildPasswordInputView(BuildContext context) {
    return  Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Container(
                height: 59,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MineTextField(placeHolderText: "请设置登录密码",onChanged: _passwordChanged,
                      hasTextChanged: _passwordTextChanged,),
                  ],
                )
            ),
            Container(
              height: 1,
              color: FYColors.color_f1f0f0,
            )
          ],
        )
    );
  }

  /// 倒计时控件
  Widget _buildCountdownText(BuildContext context) {
    String verifyTitle = "获取验证码";
    if(_countdownTime > 0) {
      verifyTitle = "${_countdownTime}S后获取";
    }

    Color textColor = FYColors.theme_color;
    if(_countdownTime > 0) {
      textColor = Colors.grey;
    }
    return GestureDetector(
        onTap: _startTimedonwTimer,
        child: Text(verifyTitle,
            style: TextStyle(fontSize: 13, color: textColor)));
  }

  /// 注册提示view
  Widget _buildRegistTipsView(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          Text(
            "已有账号，",
            style: TextStyle(fontSize: 15),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "立即登录",
              style: TextStyle(fontSize: 15, color: FYColors.theme_color),
            ),
          )
        ],
      ),
    );
  }

  /// 注册下一步验证
  Widget _buildNextStepButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 0,right: 0,bottom: 0,top: 0),
      child: RaisedButton(onPressed: enableNextStep ? _nextStepTap : null,
        child: Text("注册"),
        disabledColor: FYColors.color_cdcdcd,
        color: FYColors.theme_color,
      ),
    );
  }

  /// 用户协议
  Widget _buildRegisterUserProtocol(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("注册表示您同意",style: TextStyle(
              fontSize: 13,
              color: FYColors.color_292929
          ),),
          GestureDetector(
            onTap: (){
              print("跳转到用户协议");
            },
            child: Text(
              "泛亚生活用户协议",
              style: TextStyle(
                  fontSize: 13,
                  color: FYColors.theme_color
              ),
            ),
          )
        ],
      ),
    );
  }
}