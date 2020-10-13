import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ToggleIcon extends StatefulWidget {
  final bool selected;
  final Function onTap;
  final IconData iconData;
  final List<Color> colors;

  const ToggleIcon(
      {Key key,
      this.selected,
      this.onTap,
      this.iconData,
      @required this.colors})
      : super(key: key);

  @override
  _ToggleIconState createState() => _ToggleIconState();
}

class _ToggleIconState extends State<ToggleIcon> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _iconColorAnimation;
  bool flipped = false;
  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this, value: 0);
    _iconColorAnimation = ColorTween(
            end: widget.selected ? widget.colors[0] : widget.colors[1],
            begin: widget.selected ? widget.colors[1] : widget.colors[0])
        .animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (bc, child) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                Provider.of<ThemeModel>(context).theme.TOGGLE_GRID_BUTTON_COLOR,
          ),
          margin: EdgeInsets.all(2),
          child: IconButton(
            icon: Icon(
              widget.iconData,
              color: _iconColorAnimation.value,
            ),
            onPressed: () {
              if (!flipped) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
              flipped = !flipped;
              widget.onTap();
            },
          )),
    );
  }
}
