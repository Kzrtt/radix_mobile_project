import 'package:flutter/cupertino.dart';

import 'produtos.dart';

class Vendedor with ChangeNotifier {
  final int idVendedor;
  final String nomeVendedor;
  final String cpfCnpjVendedor;
  final String emailVendedor;
  final String senhaVendedor;
  final String urlImagemVendedor;
  final String enderecoVendedor;
  final bool statusContaVendedor;
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
}
