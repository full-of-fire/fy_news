
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TabNavigationBarItem {

  TabNavigationBarItem({
    @required this.title,
    @required this.unSelectImage,
    @required this.selectImage});

  final String title;
  final Image unSelectImage;
  final Image selectImage;
}


class TabNavigationBar extends StatefulWidget {

  const TabNavigationBar({
    Key key,
    @required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.unSelectTextColor = Colors.grey,
    this.selectTextColor = Colors.black
  }): super(key: key);

  final List<TabNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color unSelectTextColor;
  final Color selectTextColor;
  @override
  State<StatefulWidget> createState() {
    return _TabNavigationBar();
  }
}


class _TabNavigationBar extends State<TabNavigationBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final double additionalBottomPadding =
        MediaQuery.of(context).padding.bottom;
    final double height = 49;
    return Container(
      height: height + additionalBottomPadding,
      child: Container(
        margin: EdgeInsets.only(bottom: additionalBottomPadding),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, -1))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _tabItems(),
        ),
      ),
    );
  }

  List<_TabNavigationItemView> _tabItems() {
    final List<_TabNavigationItemView> titles = [];
    for (int i = 0; i < widget.items.length; i++) {
      bool centerExpand = (i == 2) ? true : false;
      _TabNavigationItemView item = _TabNavigationItemView(
        item: widget.items[i],
        centerExpand: centerExpand,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap(i);
          }
        },
        selected: i == widget.currentIndex,
        unSelectTextColor: widget.unSelectTextColor,
        selectTextColor: widget.selectTextColor,
        unSelectImage: widget.items[i].unSelectImage,
        selectImage: widget.items[i].selectImage,
      );
      titles.add(item);
    }
    return titles;
  }
}

class _TabNavigationItemView extends StatelessWidget {
  const _TabNavigationItemView({
    @required this.item,
    this.selected,
    this.centerExpand = false,
    this.onTap,
    this.unSelectTextColor,
    this.selectTextColor,
    this.unSelectImage,
    this.selectImage
  });
  final TabNavigationBarItem item;
  final bool selected;
  final bool centerExpand;
  final VoidCallback onTap;
  final Color unSelectTextColor;
  final Color selectTextColor;
  final Image unSelectImage;
  final Image selectImage;
  @override
  Widget build(BuildContext context) {
    final double additionalBottomPadding =
        MediaQuery.of(context).padding.bottom;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _topImageIcon(),
                // 标题
                _title()
              ],
            )),
      ),
    );
  }

  Widget _topImageIcon() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 5),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: [
          Positioned(
            child: _image(),
            top: centerExpand ? -30 : 0,
          )
        ],
      ),
    ));
  }

  Widget _image() {
    if (centerExpand) {
      return Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          Container(
            width: 50,
            height: 50,
            child: CustomPaint(
              size: Size(50, 50), //指定画布大小
              painter: ArcPainter(),
            ),

          ),

          Container(
            width: 50,
            height: 50,
            child: selected ? selectImage : unSelectImage,
          )
        ],
      );
    }else {
      return Container(
        width: 20,
        height: 20,
        child: selected ? selectImage : unSelectImage,
      );
    }
  }

  Widget _title() {
    return Text(
      item.title,
      style: TextStyle(
          color: selected ? selectTextColor : unSelectTextColor, fontSize: 12),
    );
  }
}


class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // var paint = Paint();
    // paint.style = PaintingStyle.stroke;
    // paint.color = Colors.red;
    //
    // canvas.drawArc(Rect.fromLTRB(0, 0, 0, 0), 0, pi, true, paint);

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Colors.white; //背景为纸黄色

    Rect shadowRect = Rect.fromCircle(center: Offset(size.width/2,size.height/2 - 1),radius: size.width/2 + 1);
    Path path = Path();
    // path.addArc(arcRect, pi, pi);
    path.addArc(shadowRect, pi, pi);
    canvas.drawShadow(path, Colors.black.withOpacity(0.1), -1, true);

    paint.color = Colors.white;
    Rect arcRect = Rect.fromCircle(center: Offset(size.width/2,size.height/2 ),radius: size.width/2 );
    canvas.drawArc(arcRect, pi, pi, false, paint);

    // Rect arcRect1 = Rect.fromCircle(center: Offset(size.width/2,size.height/2 ),radius: size.width/2 - 0.5);
    // canvas.drawArc(arcRect1, pi, pi, false, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}


