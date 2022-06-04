import 'package:flutter/material.dart';

class SalesmanTile extends StatelessWidget {
  final constraints;
  final String id;
  final String title;
  final String subTitle;
  final String threeLine;

  SalesmanTile({
    this.constraints = 100,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.threeLine,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(constraints.maxHeight * .02),
        child: SizedBox(
          height: constraints.maxHeight * .14,
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(constraints.maxWidth * .001, constraints.maxHeight * .018, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            tileColor: const Color.fromRGBO(237, 233, 232, .7),
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              radius: 50,
              child: Icon(
                Icons.abc,
                size: constraints.maxHeight * .06,
                color: const Color.fromRGBO(108, 168, 129, 1),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: constraints.maxHeight * .035,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              subTitle,
              style: TextStyle(
                fontSize: constraints.maxHeight * .025,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.fromLTRB(0, constraints.maxHeight * .020, 0, constraints.maxWidth * .01),
              child: SizedBox(
                width: constraints.maxWidth * .14,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          threeLine,
                          style: const TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
                        ),
                        const Icon(
                          Icons.eco_sharp,
                          color: Color.fromRGBO(108, 168, 129, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
