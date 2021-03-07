
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';

class MineTextField extends StatefulWidget {

  MineTextField({this.placeHolderText,this.text,this.onChanged,this.hasTextChanged,this.isSecret = false,this.textEditingController });
  /// 提示文字
  final String placeHolderText;
  final String text;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> hasTextChanged;
  final bool isSecret;
  final TextEditingController textEditingController;

  @override
  State<StatefulWidget> createState() => _MineTextFieldState();
}

class _MineTextFieldState extends State<MineTextField> {
   TextEditingController _textEditingController;
  /// 是否包含文字
  bool _hasText = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.textEditingController == null) {
      print("没有传入哦");
      _textEditingController = TextEditingController();
    }else {
      _textEditingController = widget.textEditingController;
    }
    if(widget.text != null) {
      _textEditingController.text = widget.text;
      setState(() {
        _hasText  = true;
      });
    }else {
      setState(() {
        _hasText = false;
      });
    }
    _textEditingController.addListener(() {
      if(_textEditingController.text.isNotEmpty) {
        setState(() {
          _hasText = true;

        });
        widget.hasTextChanged(true);
      }else {
        setState(() {
          _hasText = false;

        });
        widget.hasTextChanged(false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    if(_hasText) {
      return TextField(
        obscureText: widget.isSecret,
        controller: _textEditingController,
        onChanged: widget.onChanged,
        cursorColor: FYColors.theme_color,
        decoration: InputDecoration(
          hintText: widget.placeHolderText != null ? widget.placeHolderText : "请输入",
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 12,bottom: 12),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              _textEditingController.clear();
            },
          )
        ),
      );
    }else {
      return TextField(
        controller: _textEditingController,
        onChanged: widget.onChanged,
        cursorColor: FYColors.theme_color,
        decoration: InputDecoration(
            hintText: widget.placeHolderText != null ? widget.placeHolderText : "请输入",
            border: InputBorder.none,
        ),
      );
    }
  }
}