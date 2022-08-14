import 'package:flutter/material.dart';

class FavoriteTile extends StatelessWidget {
  final constraints;
  final String title;
  final leadingIcon;
  final trailingIcon;
  final Color color;

  FavoriteTile({
    required this.constraints,
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(constraints.maxHeight * .02),
      child: SizedBox(
        height: constraints.maxHeight * .14,
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(
            0,
            constraints.maxHeight * .03,
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
              color: color,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: constraints.maxHeight * .035,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.only(right: constraints.maxWidth * .04),
            child: Icon(
              trailingIcon,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
