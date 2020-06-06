import 'package:IITDAPP/values/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({
    Key key,
    AnimationController controller,
    @required IconData icon,
    @required String tag,
    @required Function onTap,
  })  : _controller = controller,
        _icon = icon,
        _tag = tag,
        _onTap = onTap,
        super(key: key);

  final AnimationController _controller;
  final IconData _icon;
  final String _tag;
  final Function _onTap;

  @override
  _CustomAnimatedButtonState createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with TickerProviderStateMixin {
  Animation<Color> _iconColorAnimation;
  Animation<Color> _buttonColorAnimation;
  AnimationController _localController;
  bool displayToggle = false;

  @override
  void initState() {
    _localController = widget._controller ??
        AnimationController(
            duration: const Duration(milliseconds: 250), vsync: this, value: 0);
    _iconColorAnimation = ColorTween(
            begin: AppColors.FLOATING_BUTTON_FG,
            end: AppColors.FLOATING_BUTTON_SELECTED_FG)
        .animate(_localController);
    _buttonColorAnimation = ColorTween(
            begin: AppColors.FLOATING_BUTTON_BG,
            end: AppColors.FLOATING_BUTTON_SELECTED_BG)
        .animate(_localController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _localController,
      builder: (ctx, child) => FloatingActionButton(
          heroTag: widget._tag,
          child: Icon(
            widget._icon,
            color: _iconColorAnimation.value,
          ),
          backgroundColor: _buttonColorAnimation.value,
          onPressed: () async {
            if ((await widget._onTap()) == true) {
              if (!displayToggle) {
                _localController.forward();
              } else {
                _localController.reverse();
              }
              displayToggle = !displayToggle;
            }
          }),
    );
  }
}
