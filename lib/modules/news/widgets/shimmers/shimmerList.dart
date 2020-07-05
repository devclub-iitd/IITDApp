import 'package:IITDAPP/modules/news/widgets/shimmers/shimmerTile.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final double width;

  const ShimmerList({Key key, @required this.itemCount, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.6),
          highlightColor: Colors.grey.withOpacity(0.4),
        enabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
              List.generate(itemCount, (index) => ShimmerTile(width: width)),
        ),
      ),
    );
  }
}
