
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/custom_ui/custom_app_bar.dart';
import 'package:fy_news/custom_ui/mine_text_field.dart';
import 'package:fy_news/generated/l10n.dart';
import 'package:fy_news/http/Api.dart';
import 'package:fy_news/model/verify_account_Info.dart';
import 'package:fy_news/modules/mine/login_enter_password.dart';
import 'package:fy_news/modules/mine/register.dart';
import 'package:fy_news/utils/navigator_util.dart';
import 'package:fy_news/utils/toast_util.dart';

class LoginConfirmPhonePage extends StatefulWidget {
  LoginConfirmPhonePage({this.mobileCode, this.moblie});

  /// 手机区号
  final String mobileCode;

  /// 手机号
  final String moblie;

  @override
  State<StatefulWidget> createState() => _LoginConfirmPhonePageState();
}

class _LoginConfirmPhonePageState extends State<LoginConfirmPhonePage> {
  /// 是否显示提示
  bool isShowTips = false;
  /// 是否显示下一步
  bool enableNextStep = true;
  /// 账号信息
  String account;
  TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

  void initState() {
    super.initState();
    tapGestureRecognizer.onTap = (){
      this._pushRegister();
    };
  }


  /// 下一步
  _nextStepTap() async {
    String mobile = widget.moblie;
    if(account != null) {
      mobile = account;
    }
    String moblieCode = widget.mobileCode;
    moblieCode = "855";
    try {
      VerifyAccountInfo info = await Api.user.verifyAccount(moblieCode: moblieCode,mobile: mobile);
      if(info.is_reg == 1) {
        //已经注册的情况，跳转到输入密码的页面
        //:TODO 区号选择的功能还没开发
        NavigatorUtil.push(page: LoginEnterPasswordPage(moblie: mobile,mobileCode: moblieCode,));

      }else {
        //未注册的情况，跳转到输入密码的页面
        if(info.is_mobile == 1) {
          //1.如果是手机就跳转确认手机的页面
          setState(() {
            isShowTips = true;
            enableNextStep = false;
          });

        }else {
          //2.如果不是手机，提示账号不存在，下一步不能点击
          setState(() {
            isShowTips = true;
            enableNextStep = false;
          });
        }
      }
    }catch(e) {
      ToastUtil.showToast(e.toString());
    }
  }
  /// 文字变化
  _textChanged(String text) {
    account = text;
  }

  _hasTextChanged(bool hasText) {
    setState(() {
      enableNextStep = hasText;
    });
  }

  /// 跳转到注册页面
  _pushRegister() {
    NavigatorUtil.push(page: RegisterPage());
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
                _buildNextStepButton(context)
              ],
            ),
          ),
        ));
  }

  /// 顶部标题
  Widget _buildTitleView(BuildContext context) {
    List<Widget> items = List();
    items.add(Text(
      S.of(context).confirm_phone_number,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ));

    items.add(_buildValidTipsView(context));
    if(isShowTips) {
      var tips = _buildAccontNotExistTipsView(context);
      items.add(tips);
    }

    return Column(
      children: items,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
  /// 验证手机号
  Widget _buildValidTipsView(BuildContext context) {
    return Text(
      "请验证国家/地区代码和电话号码",
      style: TextStyle(
        fontSize: 14,
        color: FYColors.color_999999
      ),
    );
  }

  /// 账号不存在提示view
  Widget _buildAccontNotExistTipsView(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "账号不存在，请输入其他账号或",
          style: TextStyle(
              color: Colors.red,
              fontSize: 13
          ),
          children: [
            TextSpan(
                text: "创建新账号",
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
    return Container(
        height: 60,
        margin: EdgeInsets.only(top: 45),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  // color: Colors.red,
                  height: 59,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.mobileCode)
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      height: 59,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MineTextField(placeHolderText: "请输入手机号",text:widget.moblie,onChanged: _textChanged,
                            hasTextChanged: _hasTextChanged,)
                        ],
                      )
                  ),
                )
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

  /// 注册提示view
  Widget _buildRegistTipsView(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          Text(
            "没有账号？",
            style: TextStyle(fontSize: 15),
          ),
          GestureDetector(
            onTap: _pushRegister,
            child: Text(
              "立即注册",
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
      margin: EdgeInsets.only(left: 0,right: 0,bottom: 0,top: 30),
      child: RaisedButton(onPressed: enableNextStep ? _nextStepTap : null,
        child: Text("下一步"),
        disabledColor: FYColors.color_cdcdcd,
        color: FYColors.theme_color,
      ),
    );
  }
}