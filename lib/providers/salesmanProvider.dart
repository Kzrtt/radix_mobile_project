import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalesmanProvider with ChangeNotifier {
  Row seloProdutor(double selo) {
    Row row = Row(
      children: [
        Text(
          selo.toString(),
          style: const TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
        ),
        const Icon(Icons.eco_sharp, color: Colors.cyan),
      ],
    );

    if (0 < selo && selo <= 1) {
      row = Row(
        children: [
          Text(
            selo.toString(),
            style: const TextStyle(color: Colors.red),
          ),
          const Icon(Icons.eco_sharp, color: Colors.red),
        ],
      );
    } else if (1 < selo && selo <= 2) {
      row = Row(
        children: [
          Text(
            selo.toString(),
            style: const TextStyle(color: Colors.orange),
          ),
          const Icon(Icons.eco_sharp, color: Colors.orange),
        ],
      );
    } else if (2 < selo && selo <= 3) {
      row = Row(
        children: [
          Text(
            selo.toString(),
            style: const TextStyle(color: Colors.yellow),
          ),
          const Icon(Icons.eco_sharp, color: Colors.yellow),
        ],
      );
    } else if (3 < selo && selo <= 4) {
      row = Row(
        children: [
          Text(
            selo.toString(),
            style: const TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
          ),
          const Icon(Icons.eco_sharp, color: Color.fromRGBO(108, 168, 129, 1)),
        ],
      );
    } else if (4 < selo && selo <= 5) {
      row = Row(
        children: [
          Text(
            selo.toString(),
            style: const TextStyle(color: Colors.cyan),
          ),
          const Icon(Icons.eco_sharp, color: Colors.cyan),
        ],
      );
    }

    return row;
  }

  Icon iconSeloProdutor(double selo, BoxConstraints constraints) {
    Icon icon = Icon(
      Icons.eco_sharp,
      color: Colors.cyan,
      size: constraints.maxHeight * .05,
    );

    if (0 < selo && selo <= 1) {
      icon = Icon(
        Icons.eco_sharp,
        color: Colors.red,
        size: constraints.maxHeight * .05,
      );
    } else if (1 < selo && selo <= 2) {
      icon = Icon(
        Icons.eco_sharp,
        color: Colors.orange,
        size: constraints.maxHeight * .05,
      );
    } else if (2 < selo && selo <= 3) {
      icon = Icon(
        Icons.eco_sharp,
        color: Colors.yellow,
        size: constraints.maxHeight * .05,
      );
    } else if (3 < selo && selo <= 4) {
      icon = Icon(
        Icons.eco_sharp,
        color: Color.fromRGBO(108, 168, 129, 1),
        size: constraints.maxHeight * .05,
      );
    } else if (4 < selo && selo <= 5) {
      icon = Icon(
        Icons.eco_sharp,
        color: Colors.cyan,
        size: constraints.maxHeight * .05,
      );
    }

    return icon;
  }
}
