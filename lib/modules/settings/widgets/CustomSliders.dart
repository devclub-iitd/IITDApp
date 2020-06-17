import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:flutter/material.dart';

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final min;
  final max;
  final getTextValue;

  const CustomSliderThumbCircle(
      {@required this.thumbRadius,
      this.min = 0.0,
      this.max = 10.0,
      this.getTextValue});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    // ignore: omit_local_variable_types
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor,
      ),
      text: getTextValue != null ? getTextValue((max-min)*value+min) : getValue(value),
    );

    var tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    var textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (((max-min) * value + min).round()).toString();
  }
}

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final int min;
  final int max;
  final getTextValue;

  const CustomSliderThumbRect(
      {this.thumbRadius,
      this.thumbHeight,
      this.min,
      this.max,
      this.getTextValue});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    // ignore: omit_local_variable_types
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.2, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var span = TextSpan(
        style: TextStyle(
            fontSize: thumbHeight * .3,
            fontWeight: FontWeight.w700,
            color: sliderTheme.thumbColor,
            height: 0.9),
        text: getTextValue != null ? getTextValue((max-min)*value+min) : getValue(value));
    var tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    var textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return ((max) * (value)).round().toString();
  }
}

class CustomSliders extends StatefulWidget {
  final sliderHeight;
  final min;
  final max;
  final fullWidth;
  final defaultValue;
  final divisions;
  final isRectangular;
  final getTexValue;
  final valueChangeCallback;
  final SPkey;
  CustomSliders(
      {this.sliderHeight = 48.0,
      this.max = 10.0,
      this.min = 0.0,
      this.defaultValue = 10.0,
      this.divisions,
      this.isRectangular = false,
      this.getTexValue,
      this.valueChangeCallback,
      this.fullWidth = false,
      this.SPkey});

  @override
  _CustomSlidersState createState() => _CustomSlidersState();
}

class _CustomSlidersState extends State<CustomSliders> {
  var _value;

  @override
  void initState() {
    // TODO: implement initState
    _value = widget.defaultValue;
    getValue();
    super.initState();
  }

  Future<void> getValue() async{
    if(widget.SPkey==null) {
      return;
    }
    var res = await SettingsHandler.getSettingValue(widget.SPkey);
    setState(() {
      _value = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    var paddingFactor = .2;

    if (widget.fullWidth) paddingFactor = .3;

    return Container(
      width: widget.fullWidth ? double.infinity : (widget.sliderHeight) * 5.5,
      height: (widget.sliderHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular((widget.sliderHeight * .3)),
        ),
        gradient: LinearGradient(
            colors: [
              const Color(0xFF00c6ff),
              const Color(0xFF0072ff),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.00),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(widget.sliderHeight * paddingFactor, 2,
            widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              '${widget.min}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white
                        .withOpacity(widget.divisions != null ? 0 : 1),
                    inactiveTrackColor: Colors.white
                        .withOpacity(widget.divisions != null ? 0 : 0.5),
                    trackHeight: 4.0,
                    thumbShape: widget.isRectangular
                        ? CustomSliderThumbRect(
                            thumbRadius: widget.sliderHeight * .4,
                            min: widget.min,
                            max: widget.max,
                            thumbHeight: widget.sliderHeight,
                            getTextValue: widget.getTexValue)
                        : CustomSliderThumbCircle(
                            thumbRadius: widget.sliderHeight * .4,
                            min: widget.min,
                            max: widget.max,
                            getTextValue: widget.getTexValue),
                    overlayColor: Colors.white.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.white.withOpacity(.7),
                  ),
                  child: Slider(
                      min: widget.min,
                      max: widget.max,
                      value: _value,
                      divisions: widget.divisions,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                        widget.SPkey!=null?SettingsHandler.setSettingValue(widget.SPkey, value):null;
                        widget.valueChangeCallback != null
                            ? widget.valueChangeCallback(value)
                            : null;
                      }),
                ),
              ),
            ),
            SizedBox(
              width: widget.sliderHeight * .1,
            ),
            Text(
              '${widget.max}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
