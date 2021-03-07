
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/strings/FYStrings.dart';
import 'package:fy_news/utils/navigator_util.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({this.title, this.tail,this.onTap});
  final Widget title;
  final Widget tail;
  final VoidCallback onTap;
  @override
  State<StatefulWidget> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(44);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    double marginTop = MediaQuery.of(context).padding.top;
    final double height = marginTop + widget.preferredSize.height;
    return Container(
      height: height,
      color: Colors.white,
      child: Container(
        height: widget.preferredSize.height,
        margin: EdgeInsets.only(top: marginTop),
        child: Row(
          children: _buildItems(context),
        ),
      ),
    );
  }

  ///
  List<Widget> _buildItems(BuildContext context) {
    List<Widget> items = List();
    items.add(_buildBackItem(context));
    if(widget.title != null){
      items.add(
        Expanded(child:widget.title)
      );
    }
    if(widget.tail != null) {
      items.add(widget.tail);
    }
    return items;
  }

  /// 返回item
  Widget _buildBackItem(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 44,
        child: Image.asset(FYStrings.mine_back),
      ),
      onTap: (){
        Navigator.pop(context);
        if(widget.onTap != null) {
          widget.onTap();
        }
      },
    );
  }

}