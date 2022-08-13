import 'package:flutter/cupertino.dart';

class Endereco {
  final int idEndereco;
  final String apelidoEndereco;
  final String endereco;
  final String complemento;
  final String numero;
  final int statusEndereco;

  Endereco({
    required this.idEndereco,
    required this.apelidoEndereco,
    required this.endereco,
    required this.complemento,
    required this.numero,
    required this.statusEndereco,
  });
}
