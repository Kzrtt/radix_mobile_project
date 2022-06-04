import 'package:flutter/material.dart';

class HistoricTile extends StatelessWidget {
  final constraints;
  final String title;
  final String subTitle;
  final trailingIcon;
  final temporaryString; //Mudar essa String para adaptar a diversas linhas posteriormente

  HistoricTile({
    required this.constraints,
    required this.title,
    required this.subTitle,
    required this.trailingIcon,
    required this.temporaryString,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(constraints.maxHeight * .02),
      child: SizedBox(
        height: constraints.maxHeight * .20,
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(
            constraints.maxWidth * .05,
            constraints.maxHeight * .03,
            0,
            0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: const Color.fromRGBO(237, 233, 232, .7),
          title: Text(
            title,
            style: TextStyle(
              fontSize: constraints.maxHeight * .035,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: constraints.maxHeight * .005),
            child: Text(
              '$subTitle \n $temporaryString',
              style: TextStyle(
                fontSize: constraints.maxHeight * .025,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.fromLTRB(
                0, constraints.maxWidth * .010, constraints.maxWidth * .04, 0),
            child: Column(
              children: [
                Icon(
                  trailingIcon,
                  color: const Color.fromRGBO(108, 168, 129, 1),
                ),
                Text(
                  'Pedir novamente',
                  style: TextStyle(
                    fontSize: constraints.maxHeight * .018,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
