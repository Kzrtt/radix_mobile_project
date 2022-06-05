// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/appRoutes.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final double height;
  final double width;
  final double fontSize;
  final bool color;

  const Button({required this.text, required this.onTap, required this.height, required this.width, this.fontSize = 15, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: height,
          width: width,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color ? Color.fromRGBO(132, 202, 157, 1) : Color.fromRGBO(235, 234, 232, 1)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  color: color ? Colors.white : Color.fromRGBO(132, 202, 157, 1),
                ),
              ),
            ),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
