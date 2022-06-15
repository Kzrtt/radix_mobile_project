import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/imageContainer.dart';

class TextPlusImage extends StatelessWidget {
  final String imgUrl;
  final String firstText;
  final String secondText;
  final double height;
  final constraints;

  TextPlusImage(
      {required this.firstText,
      required this.imgUrl,
      required this.secondText,
      required this.height,
      required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageContainer(imgUrl, height),
        SizedBox(height: constraints.maxHeight * .05),
        SizedBox(
          height: constraints.maxHeight * .08,
          width: constraints.maxWidth,
          child: Center(
            child: Text(
              firstText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: constraints.maxHeight * .03,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: constraints.maxHeight * .01),
          height: constraints.maxHeight * .09,
          width: constraints.maxWidth * .75,
          child: Center(
            child: Text(
              secondText,
              style: TextStyle(
                fontSize: constraints.maxHeight * .0225,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
