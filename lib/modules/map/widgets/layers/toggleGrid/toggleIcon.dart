import 'package:IITDAPP/values/colors/colors.dart';
import 'package:flutter/material.dart';

class ToggleIcon extends StatefulWidget {
  final bool selected;
  final Function onTap;
  final IconData iconData;
  const ToggleIcon({Key key, this.selected, this.onTap, this.iconData})
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
            end: widget.selected
                ? AppColors.TOGGLE_GRID_BUTTON_ICON_DISABLED_COLOR
                : AppColors.TOGGLE_GRID_BUTTON_ICON_COLOR,
            begin: widget.selected
                ? AppColors.TOGGLE_GRID_BUTTON_ICON_COLOR
                : AppColors.TOGGLE_GRID_BUTTON_ICON_DISABLED_COLOR)
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
            color: AppColors.TOGGLE_GRID_BUTTON_COLOR,
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
