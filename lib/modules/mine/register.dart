
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/custom_ui/custom_app_bar.dart';
import 'package:fy_news/custom_ui/mine_text_field.dart';
import 'package:fy_news/generated/l10n.dart';
import 'package:fy_news/http/Api.dart';
import 'package:fy_news/model/verify_account_Info.dart';
import 'package:fy_news/modules/mine/register_password.dart';
import 'package:fy_news/utils/navigator_util.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  /// 是否显示账号已存在提示
  bool isShowAccountExist = false;
  /// 是否显示下一步
  bool enableNextStep = false;
  /// 手机号码
  String moblie;
  TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

  void initState() {
    super.initState();
    tapGestureRecognizer.onTap = (){
      Navigator.pop(context);
    };
  }


  /// 下一步
  _nextStepTap() async {

    //1.检测账号是否存在
    VerifyAccountInfo accountInfo = await Api.user.verifyAccount(moblieCode: "855",mobile: moblie);
    if(accountInfo.is_reg == 1) {
      setState(() {
        isShowAccountExist = true;
      });
    }else {
      setState(() {
        isShowAccountExist = false;
      });
      //2.没有存在就跳转到设置密码页面
      NavigatorUtil.push(page: RegisterPasswordPage(moblie: moblie,moblieCode: "855",));
    }
  }
  /// 文字变化
  _textChanged(String text) {
    moblie = text;
  }

  _hasTextChanged(bool hasText) {
    setState(() {
      enableNextStep = hasText;
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
                // 注册提示
                _buildRegistTipsView(context),
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
    if(isShowAccountExist) {
      items.add(_buildAccontExistTipsView(context));
    }
    return Column(
      children: items,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }


  /// 账号存在提示view
  Widget _buildAccontExistTipsView(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "手机号已注册，请输入其他手机号或",
          style: TextStyle(
              color: Colors.red,
              fontSize: 13
          ),
          children: [
            TextSpan(
                text: "前往登录",
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
                      Text("+855")
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      height: 59,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MineTextField(onChanged: _textChanged,
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
        child: Text("下一步"),
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