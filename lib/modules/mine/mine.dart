
import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: _items(),
        ),
      )
    );
  }

  List<Widget> _items() {
    List<Widget> items = List<Widget>();
    for(int i = 0; i < 100; i++){
      items.add(Text("第几个 = {i}"));
    }

    return items;
  }
}