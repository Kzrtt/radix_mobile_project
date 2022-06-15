import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  final double height;

  const ImageContainer(this.imageUrl, this.height);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(imageUrl, height: height);
  }
}
