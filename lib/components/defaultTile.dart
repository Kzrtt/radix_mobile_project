import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DefaultTile extends StatelessWidget {
  final constraints;
  final String title;
  final String subTitle;
  final leadingIcon;

  DefaultTile({
    required this.constraints,
    required this.subTitle,
    required this.title,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(constraints.maxHeight * .02),
      child: SizedBox(
        height: constraints.maxHeight * .14,
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(
            constraints.maxWidth * .01,
            constraints.maxHeight * .018,
            0,
            0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: const Color.fromRGBO(237, 233, 232, .7),
          leading: CircleAvatar(
            backgroundColor: Colors.black12,
            radius: 50,
            child: Icon(
              leadingIcon,
              size: constraints.maxHeight * .06,
              color: const Color.fromRGBO(108, 168, 129, 1),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: constraints.maxHeight * .04,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: TextStyle(
              fontSize: constraints.maxHeight * .02,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
