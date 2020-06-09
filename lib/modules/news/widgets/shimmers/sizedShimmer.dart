import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SizedShimmer extends StatelessWidget {
  const SizedShimmer({Key key, this.width, @required this.height, this.baseColor, this.highlightColor,})
      : super(key: key);

  final double width;
  final double height;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: (baseColor??Colors.grey[800]),
      highlightColor: (highlightColor??Colors.grey[700]),
      enabled: true,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        width: width,
        height: height,
      ),
    );
  }
}
