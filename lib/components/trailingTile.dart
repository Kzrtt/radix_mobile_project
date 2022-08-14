// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';
import 'package:radix_mobile_project/providers/paymentProvider.dart';

class TrailingTile extends StatelessWidget {
  final constraints;
  final String id;
  final String title;
  final String subTitle;
  final leadingIcon;
  final trailingIcon;
  final bool color;

  TrailingTile({
    this.constraints = 100,
    required this.id,
    required this.title,
    this.subTitle = '',
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
            constraints.maxWidth * .01,
            constraints.maxHeight * .015,
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
          title: Text(
            title,
            style: TextStyle(
              fontSize: constraints.maxHeight * .025,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: TextStyle(
              fontSize: constraints.maxHeight * .018,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.fromLTRB(0, constraints.maxHeight * .0003,
                constraints.maxWidth * .04, 0),
            child: IconButton(
              icon: Icon(trailingIcon),
              color: color ? Colors.red : Colors.black,
              onPressed: () =>
                  Provider.of<PaymentProvider>(context, listen: false)
                      .deleteCartao(id),
            ),
          ),
        ),
      ),
    );
  }
}
