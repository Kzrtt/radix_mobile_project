import 'package:flutter/material.dart';

import 'produtos.dart';

class Vendedor with ChangeNotifier {
  final int idVendedor;
  final String nomeVendedor;
  final String cpfCnpjVendedor;
  final String emailVendedor;
  final String senhaVendedor;
  final String urlImagemVendedor;
  final String enderecoVendedor;
  final int statusContaVendedor;
  final double selo;
  final List<Produtos> produtosVendedor;

  Vendedor({
    required this.idVendedor,
    required this.nomeVendedor,
    required this.cpfCnpjVendedor,
    required this.emailVendedor,
    required this.senhaVendedor,
    required this.urlImagemVendedor,
    required this.enderecoVendedor,
    required this.statusContaVendedor,
    required this.selo,
    required this.produtosVendedor,
  });

  Row seloProdutor() {
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
            style: const TextStyle(color: Colors.green),
          ),
          const Icon(Icons.eco_sharp, color: Colors.green),
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
}
