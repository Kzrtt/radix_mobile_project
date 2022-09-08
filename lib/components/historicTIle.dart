import 'package:flutter/material.dart';
import 'dart:math' as math;

class HistoricTile extends StatefulWidget {
  final constraints;
  final String title;
  final String subTitle;
  final trailingIcon;

  HistoricTile({
    required this.constraints,
    required this.title,
    required this.subTitle,
    required this.trailingIcon,
  });

  @override
  State<HistoricTile> createState() => _HistoricTileState();
}

class _HistoricTileState extends State<HistoricTile> {
  @override
  Widget build(BuildContext context) {
    bool _expanded = false;

    return Padding(
      padding: EdgeInsets.all(widget.constraints.maxHeight * .02),
      child: Column(
        children: [
          SizedBox(
            height: widget.constraints.maxHeight * .16,
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(
                widget.constraints.maxWidth * .05,
                widget.constraints.maxHeight * .025,
                0,
                0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              tileColor: const Color.fromRGBO(237, 233, 232, .7),
              title: Text(
                widget.title,
                style: TextStyle(
                  fontSize: widget.constraints.maxHeight * .030,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: widget.constraints.maxHeight * .005),
                child: Text(
                  widget.subTitle,
                  style: TextStyle(
                    fontSize: widget.constraints.maxHeight * .025,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              trailing: Padding(
                padding: EdgeInsets.only(right: widget.constraints.maxWidth * .05),
                child: Transform.rotate(
                  angle: 270 * math.pi / 180,
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      widget.trailingIcon,
                      color: const Color.fromRGBO(108, 168, 129, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
