import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,@required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.4),
      highlightColor: Colors.grey.withOpacity(0.6),
      enabled: true,
      child: Column(
        children: List.generate(
            2,
            (index) => Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Container(
                    color: Colors.white,
                    height: height,
                  ),
                )),
      ),
    );
  }
}
