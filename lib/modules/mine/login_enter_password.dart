
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/custom_ui/custom_app_bar.dart';
import 'package:fy_news/custom_ui/mine_text_field.dart';
import 'package:fy_news/generated/l10n.dart';
import 'package:fy_news/http/Api.dart';
import 'package:fy_news/model/verify_account_Info.dart';
import 'package:fy_news/modules/mine/register.dart';
import 'package:fy_news/utils/navigator_util.dart';
import 'package:fy_news/utils/toast_util.dart';

class LoginEnterPasswordPage extends StatefulWidget {
  LoginEnterPasswordPage({this.mobileCode, this.moblie});

  /// 手机区号
  final String mobileCode;

  /// 手机号
  final String moblie;

  @override
  State<StatefulWidget> createState() => _LoginEnterPasswordPageState();
}

enum LoginType {
  ///账号密码 =1
  accountPassword,
  ///手机验证码
  phoneVerifyCode,
  ///手机密码
  phonePassword
}

class _LoginEnterPasswordPageState extends State<LoginEnterPasswordPage> {
  
  /// 是否允许登录
  bool enableLogin = true;
  /// 密码
  String _password;
  /// 登录样式
  LoginType loginType = LoginType.accountPassword;
  
  TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
  /// 密码输入框控制器
  TextEditingController passwordTextEditController = TextEditingController();

  Timer _timer;

  int _countdownNum = 0;

  @override
  void initState() {
    super.initState();
    tapGestureRecognizer.onTap = (){
      this._pushExchangeAccount();
    };
  }

  @override
  void dispose() {
    super.dispose();
    if(_timer != null) {
      _timer.cancel();
    }
  }

  /// 登录
  _nextStepTap() async {
  
  }
  /// 文字变化
  _textChanged(String text) {
    _password = text;
  }

  _hasTextChanged(bool hasText) {
    setState(() {
      enableLogin = hasText;
    });
  }

  /// 跳转到切换账号页面
  _pushExchangeAccount() {
    Navigator.pop(context);
  }
  /// 跳转到忘记密码
  _pushForgetPassword() {
    print("忘记密码");
  }
  /// 验证码登录
  _verifyCodeLogin() {
    print("验证码登录");
    //1.发送验证码

    //2.如果验证发送成功就今日倒计时
    setState(() {
      _countdownNum = 60;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_countdownNum < 1) {
          _timer.cancel();
        }else {
          _countdownNum -= 1;
        }
      });
    });

    passwordTextEditController.clear();
    setState(() {
      loginType = LoginType.phoneVerifyCode;
    });
  }
  /// 密码登录
  _passwordLogin() {
    print("密码登录");
    passwordTextEditController.clear();
    setState(() {
      loginType = LoginType.phonePassword;
      _countdownNum = 0;
    });
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
                // 切换登录方式
                _buildExchangeLoginTypeView(context),
                // 登录
                _buildLoginButton(context)
              ],
            ),
          ),
        ));
  }

  /// 顶部标题
  Widget _buildTitleView(BuildContext context) {
    List<Widget> items = List();

    String title;
    if(loginType == LoginType.accountPassword || loginType == LoginType.phonePassword) {
      title = "请输入密码";
    }else {
      title = "输入验证码";
    }
    items.add(Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ));
    var tips = _buildChangeAccountView(context);
    items.add(tips);
    return Column(
      children: items,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  /// 切换账号view
  Widget _buildChangeAccountView(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "+${widget.mobileCode} ${widget.moblie}",
          style: TextStyle(
              color: Colors.red,
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
    List<Widget> items = List();
    items.add(Expanded(
      child: _buildPasswordTextFileView(context),
    ));
    if(loginType == LoginType.phoneVerifyCode) {
      items.add(_buildCountdownView(context));
    }
    return Container(
        height: 60,
        margin: EdgeInsets.only(top: 45),
        child: Column(
          children: [
            Row(
              children:items,
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
  Widget _buildPasswordTextFileView(BuildContext context) {
    return Container(
        height: 59,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MineTextField(
              placeHolderText: "请输入密码",
              onChanged: _textChanged,
              hasTextChanged: _hasTextChanged,
              isSecret: false,
              textEditingController: passwordTextEditController,
            )
          ],
        )
    );
  }

  /// 倒计时view
  Widget _buildCountdownView(BuildContext context) {
    return GestureDetector(
      onTap: _countdownNum > 0 ? null : _verifyCodeLogin,
      child: Text(
        _countdownNum > 0 ? "${_countdownNum}S 获取" : "重新获取",
        style: TextStyle(
          fontSize: 13,
          color: _countdownNum > 0 ? FYColors.color_999999 : FYColors.theme_color
        ) ,
      ),
    );
  }


  /// 切换登录是view
  Widget _buildExchangeLoginTypeView(BuildContext context) {
    List<Widget> items = List();
    if(loginType == LoginType.accountPassword || loginType == LoginType.phonePassword) {
      items.add(_buildForgetPasswordView(context));
      items.add(_buildVerifyCodeLoginView(context));
    }else {
      items.add(_buildPasswordLoginView(context));
    }
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      ),
    );
  }

  /// 忘记密码
  Widget _buildForgetPasswordView(BuildContext context) {
    return GestureDetector(
      child: Text(
          "忘记密码？",
        style: TextStyle(
          fontSize: 13,
          color: FYColors.color_999999
        ),
      ),
      onTap: _pushForgetPassword,
    );
  }
  /// 验证码登录
  Widget _buildVerifyCodeLoginView(BuildContext context) {
    return GestureDetector(
      child: Text(
        "验证码登录",
        style: TextStyle(
            fontSize: 13,
            color: FYColors.theme_color
        ),
      ),
      onTap: _verifyCodeLogin,
    );
  }
  /// 使用密码登录
  Widget _buildPasswordLoginView(BuildContext context) {
    return GestureDetector(
      child: Text(
        "使用密码登录",
        style: TextStyle(fontSize: 13, color: FYColors.theme_color),
      ),
      onTap: _passwordLogin,
    );
  }
  /// 登录
  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 0,right: 0,bottom: 0,top: 0),
      child: RaisedButton(onPressed: enableLogin ? _nextStepTap : null,
        child: Text("下一步"),
        disabledColor: FYColors.color_cdcdcd,
        color: FYColors.theme_color,
      ),
    );
  }
}