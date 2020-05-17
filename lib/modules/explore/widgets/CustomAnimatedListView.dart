import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class CustomAnimatedListView extends StatefulWidget {
  var list;
  CustomAnimatedListView({Key key, this.list}) : super(key: key);
  @override
  _CustomAnimatedListViewState createState() => _CustomAnimatedListViewState();
}

class _CustomAnimatedListViewState extends State<CustomAnimatedListView> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: FlipAnimation(
                  flipAxis: FlipAxis.y,
                  child: widget.list[index],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
