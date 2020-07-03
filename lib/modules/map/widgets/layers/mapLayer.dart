import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:latlong/latlong.dart';

import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';
import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/widgets/layers/markerLayer.dart';
import 'package:IITDAPP/modules/map/data/mapOffsets.dart';
// Given a canvas and an image, determine what size the image should be to be
// contained in but not exceed the canvas while preserving its aspect ratio.

class MapLayer extends StatefulWidget {
  final ImageProvider image;
  final double maxScale;
  final Color backgroundColor;
  final Widget placeholder;
  final LatLng NW;
  final LatLng SE;
  final List<Marker> markers;
  const MapLayer(this.image,
      {Key key,
      double scale,

      /// Maximum ratio to blow up image pixels. A value of 2.0 means that the
      /// a single device pixel will be rendered as up to 4 logical pixels.
      this.maxScale = 2.0,
      this.backgroundColor = Colors.grey,

      /// Placeholder widget to be used while [image] is being resolved.
      this.placeholder,
      this.NW,
      this.SE,
      this.markers})
      : super(key: key);

  @override
  _MapLayerState createState() => _MapLayerState();
}

// See /flutter/examples/layers/widgets/gestures.dart
class _MapLayerState extends State<MapLayer> {
  ImageStream _imageStream;
  ui.Image _image;

  Offset _startingFocalPoint;

  Offset _previousOffset;
  // Offset _tweenStartOffset;

  double _previousScale;
  double _minScale; // multiplier applied to scale the full image

  Orientation _previousOrientation;
  MapOffset mo;

  bool scaleChanged = false;
  bool slideBreak = false;

  void _centerAndScaleImage() {
    print('centre and scale');
    mo.imageSize = Size(
      _image.width.toDouble(),
      _image.height.toDouble(),
    );

    mo.scale = math.max(
      mo.canvasSize.width / mo.imageSize.width,
      mo.canvasSize.height / mo.imageSize.height,
    );
    _minScale = mo.scale;
    var fitted = Size(
      mo.imageSize.width * mo.scale,
      mo.imageSize.height * mo.scale,
    );

    Offset delta = mo.canvasSize - fitted;
    mo.offset = delta / 2.0; // Centers the image

    // print(mo.scale);
  }

  Function() _handleDoubleTap(BuildContext ctx) {
    return () {
      var newScale = mo.scale * 2;
      if (newScale > widget.maxScale) {
        _centerAndScaleImage();
        setState(() {});
        return;
      }

      // We want to zoom in on the center of the screen.
      // Since we're zooming by a factor of 2, we want the new offset to be twice
      // as far from the center in both width and height than it is now.
      var center = ctx.size.center(Offset.zero);
      var newOffset = mo.offset - (center - mo.offset);

      mo.animationCurve = Curves.linear;
      mo.panDuration = 0;
      mo.scale = newScale;
      mo.changeOffsets(newOffset);
      // _moveTo(_getOffset(LatLng(28.547457,77.187354)));
    };
  }

  void _handleScaleStart(ScaleStartDetails d) {
    // print('starting scale at ${d.focalPoint} from $mo.offset $mo.scale');
    scaleChanged = false;
    _startingFocalPoint = d.focalPoint;
    _previousOffset = mo.offset;
    _previousScale = mo.scale;
  }

  void _handleScaleEnd(ScaleEndDetails d) {
    // slide physics
    if (scaleChanged) {
      slideBreak = true;
      Future.delayed(Duration(milliseconds: 100), () => slideBreak = false);
      return;
    }
    if (slideBreak) {
      return;
    }
    // print('sliding');
    var acc = 10000;
    var velocity = d.velocity.pixelsPerSecond;
    // print(velocity);
    var speed =
        math.sqrt(velocity.dx * velocity.dx + velocity.dy * velocity.dy);
    mo.animationCurve = Curves.easeOutQuint;
    mo.panDuration = (speed / acc * 1000).round() * 2;
    // var time = (speed/acc*1000).round()*2;
    // print(time);
    var dx = (velocity.dx * (velocity.dx).abs()) / (2 * acc);
    var dy = (velocity.dy * (velocity.dy).abs()) / (2 * acc);
    // print(dx);
    // print(dy);
    mo.changeOffsets(Offset(mo.offset.dx + dx, mo.offset.dy + dy));
  }

  void _handleScaleUpdate(ScaleUpdateDetails d) {
    //TODO handle move interrupt

    var newScale = _previousScale * d.scale;
    if (newScale > widget.maxScale || newScale < _minScale) {
      return;
    }

    // Ensure that item under the focal point stays in the same place despite zooming
    final normalizedOffset =
        (_startingFocalPoint - _previousOffset) / _previousScale;
    final newOffset = d.focalPoint - normalizedOffset * newScale;

    if (d.scale != 1) {
      scaleChanged = true;
    }

    mo.animationCurve = Curves.linear;
    mo.panDuration = 0;
    mo.scale = newScale;
    mo.changeOffsets(newOffset);
  }

  @override
  Widget build(BuildContext ctx) {
    Color blendColor = Provider.of<ThemeModel>(context).theme.MAP_BLEND_COLOR;
    print('built map layer');
    mo = Provider.of<MapOffset>(ctx, listen: false);
    Widget paintWidget() {
      return MoveAroundWidget(
        child: mapImageBody,
      );
      // return CustomPaint(
      //     child: Container(color: widget.backgroundColor),
      //     foregroundPainter: _MapLayerPainter(
      //       image: _image,
      //       offset: mo.offset,
      //       scale: mo.scale,
      //     ),
      //   );
    }

    if (_image == null) {
      return widget.placeholder ?? Center(child: CircularProgressIndicator());
    }

    return LayoutBuilder(builder: (ctx, constraints) {
      var orientation = MediaQuery.of(ctx).orientation;
      if (orientation != _previousOrientation) {
        _previousOrientation = orientation;
        mo.canvasSize = constraints.biggest;
        _centerAndScaleImage();
      }

      return Stack(children: [
        GestureDetector(
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  blendColor.withOpacity(0.35), BlendMode.luminosity),
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      blendColor.withOpacity(0.35), BlendMode.colorBurn),
                  child: paintWidget())),
          onTap: () {
            Provider.of<MapConditions>(context, listen: false)
                .markerSelected(-1);
          },
          onDoubleTap: _handleDoubleTap(ctx),
          onScaleStart: _handleScaleStart,
          onScaleUpdate: _handleScaleUpdate,
          onScaleEnd: _handleScaleEnd,
        ),
        MoveAroundWidget(child: markerLayer)
      ]);
    });
  }

  Widget markerLayer(bc, Offset tweenOffset, _) {
    print('built marker layer');
    // print('rebult marker layer');
    var mo = Provider.of<MapOffset>(bc, listen: false);
    var mc = Provider.of<MapConditions>(bc, listen: false);
    var visibleMarkers = mc.markers.where((m) {
      mc.onScreenOffset[m.id] = mo.getOffset(
          //positions updated every frame as of now
          globalPosition: m.location.location,
          tweenOffset: mo.verifyOffset(tweenOffset));
      if (Marker.zoomLevel(m.minScale) > mo.scale) {
        return false;
      }

      if (m.location.type != null && !mc.isVisible(m.location.type)) {
        return false;
      }
      return (mc.onScreenOffset[m.id].dx <= mo.canvasSize.width &&
          mc.onScreenOffset[m.id].dx >= 0 &&
          mc.onScreenOffset[m.id].dy <= mo.canvasSize.height &&
          mc.onScreenOffset[m.id].dy >= 0);
    });
    return MarkerLayer(
      visibleMarkers: visibleMarkers,
      tweenOffset: tweenOffset,
    );
  }

  Widget mapImageBody(bc, Offset tweenOffset, _) {
    return CustomPaint(
      child: Container(color: widget.backgroundColor),
      foregroundPainter: _MapLayerPainter(
        image: _image,
        offset:
            mo.panDuration == 0 ? tweenOffset : mo.verifyOffset(tweenOffset),
        scale: mo.scale,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _resolveImage();
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    _resolveImage(); // in case the image cache was flushed
    super.reassemble();
  }

  void _resolveImage() {
    _imageStream = widget.image.resolve(createLocalImageConfiguration(context));
    _imageStream.addListener(ImageStreamListener(_handleImageLoaded));
  }

  void _handleImageLoaded(ImageInfo info, bool synchronousCall) {
    print('image loaded: $info');
    setState(() {
      _image = info.image;
    });
  }

  @override
  void dispose() {
    _imageStream.removeListener(ImageStreamListener(_handleImageLoaded));
    super.dispose();
  }
}

class MoveAroundWidget extends StatelessWidget {
  const MoveAroundWidget({
    Key key,
    this.child,
  }) : super(key: key);

  final child;
  @override
  Widget build(BuildContext context) {
    return Consumer<MapOffset>(
      builder: (_, _mo, c) => TweenAnimationBuilder(
          curve: _mo.animationCurve ?? Curves.linear,
          tween: Tween<Offset>(begin: _mo.tweenPreviousOffset, end: _mo.offset),
          duration: Duration(milliseconds: _mo.panDuration),
          builder: child),
    );
  }
}

class _MapLayerPainter extends CustomPainter {
  const _MapLayerPainter({this.image, this.offset, this.scale});

  final ui.Image image;
  final Offset offset;
  final double scale;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    var imageSize = Size(image.width.toDouble(), image.height.toDouble());
    var targetSize = imageSize * scale;
    paintImage(
      canvas: canvas,
      rect: offset & targetSize,
      image: image,
      fit: BoxFit.fill,
    );
  }

  @override
  bool shouldRepaint(_MapLayerPainter old) {
    return old.image != image || old.offset != offset || old.scale != scale;
  }
}
