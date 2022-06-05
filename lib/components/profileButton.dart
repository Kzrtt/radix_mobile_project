import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final title;
  final subTitle;
  final constraints;
  final leading;
  final traicing;
  final Function(BuildContext context) route;

  ProfileButton({
    required this.title,
    this.subTitle = '',
    required this.constraints,
    required this.leading,
    required this.traicing,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => route(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: constraints.maxWidth * .015,
          horizontal: constraints.maxHeight * .02,
        ),
        child: SizedBox(
          height: constraints.maxHeight * .13,
          child: ListTile(
            contentPadding: EdgeInsets.only(top: constraints.maxHeight * .008),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            tileColor: const Color.fromRGBO(237, 233, 232, .7),
            title: Text(
              title,
              style: TextStyle(
                fontSize: constraints.maxHeight * .038,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              subTitle,
              style: TextStyle(
                fontSize: constraints.maxHeight * .024,
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: constraints.maxWidth * .03),
              child: Icon(
                leading,
                size: constraints.maxHeight * .06,
                color: const Color.fromRGBO(108, 168, 129, 1),
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(right: constraints.maxWidth * .03),
              child: Icon(
                traicing,
                size: constraints.maxHeight * .04,
                color: const Color.fromRGBO(108, 168, 129, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
