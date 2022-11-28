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
      padding: EdgeInsets.only(left: constraints.maxHeight * .02, top: constraints.maxHeight * .05, right: constraints.maxHeight * .02),
      child: SizedBox(
        height: constraints.maxHeight * .14,
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(
            constraints.maxWidth * .01,
            constraints.maxHeight * .02,
            0,
            0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: const Color.fromRGBO(237, 233, 232, .7),
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(20, 0, 0, 0),
            radius: 50,
            child: Icon(
              leadingIcon,
              size: constraints.maxHeight * .06,
              color: const Color.fromRGBO(108, 168, 129, 1),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: constraints.maxHeight * .0125),
            child: Text(
              title,
              style: TextStyle(
                fontSize: constraints.maxHeight * .04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          isThreeLine: true,
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
