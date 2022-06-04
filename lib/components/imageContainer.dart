import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double margin;

  const ImageContainer(this.imageUrl, this.height, this.width, this.margin);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(margin),
      child: Image.asset(imageUrl),
    );
  }
}
