
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/colors/FYColors.dart';
import 'package:fy_news/const/strings/FYStrings.dart';

class SystemItemWidget extends StatelessWidget {

  const SystemItemWidget({
    this.leading,
    this.title,
    this.tail,
    this.onClick,
    this.height = 51,
    this.isShowIndicator = true
  });
  final Widget leading;
  final Widget title;
  final Widget tail;
  final VoidCallback onClick;
  final double height;
  final bool isShowIndicator;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              height: height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildRowItems(),
              ),
            ),
            Positioned(
              child: Container(
                height: 1,
                color: FYColors.color_f7f7f7,
              ),
              left: 15,
              bottom: 0,
              right: 0,
            )
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  List<Widget> _buildRowItems() {
    List<Widget> rowItems = [];
    if(leading != null) {
      rowItems.add(leading);
    }
    if(title != null) {
      rowItems.add(title);
    }
    rowItems.add(Spacer());
    if(tail != null) {
      rowItems.add(tail);
    }
    if(isShowIndicator) {
      rowItems.add(
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Image.asset(FYStrings.mine_right_arrow),
        )
      );
    }
    return rowItems;
  }
}