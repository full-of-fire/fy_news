
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';


enum ListScrollDirection {
  /// 向上滚动
  up,
  /// 向下滚动
  down,
}

typedef ListScrollDirectonValueChange = void Function(ListScrollDirection);

class NewsListPage extends StatefulWidget {
  const NewsListPage({this.listScrollDirectonValueChange});
  final ListScrollDirectonValueChange listScrollDirectonValueChange;

  @override
  State<StatefulWidget> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  ScrollController _scrollController = ScrollController();
  double _startOffset = 0;
  final double _maxOffset = 60;


  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _handleNotice,
      child: ListView(
        controller: _scrollController,
        children: _items(),
      ),
    );
  }

  List<Widget> _items() {
    List<Widget> items = [];
    for(int i = 0; i < 100; i++) {
      items.add(Text("第${i+1}个item"));
    }
    return items;
  }

  /*处理通知*/
  bool _handleNotice(Notification notification){

    if(notification is ScrollStartNotification) {
      print(notification.dragDetails);
      print("开始滚动");
      _startOffset = _scrollController.offset;
    }else if (notification is ScrollUpdateNotification) {

      // print(notification.scrollDelta);
      if(_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if(_startOffset - _scrollController.offset > _maxOffset) {
          print("向下滚动 超过60");
          widget.listScrollDirectonValueChange(ListScrollDirection.down);
        }
        // print("向下滚动==${_scrollController.offset}");
      }else if(_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if(_scrollController.offset - _startOffset   > _maxOffset) {
          print("向上滚动 超过60");
          widget.listScrollDirectonValueChange(ListScrollDirection.up);
        }
      }

    }else if (notification is ScrollEndNotification) {
      print("滚动结束");
    }
    return true;

  }
}