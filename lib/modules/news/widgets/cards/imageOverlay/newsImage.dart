import 'package:IITDAPP/values/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/news/widgets/shimmers/sizedShimmer.dart';

class NewsImage extends StatelessWidget {
  const NewsImage({
    Key key,
    @required this.url,
    this.width,
    this.height,
  }) : super(key: key);

  final String url;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? defaultImage,
      placeholder: (_, s) => SizedShimmer(width: width, height: height),
      imageBuilder: (_, ip) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ip,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
