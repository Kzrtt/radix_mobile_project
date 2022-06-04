import 'package:radix_mobile_project/model/endereco.dart';

class Cliente {
  final int idCliente;
  final String nomeCliente;
  final String cpfCliente;
  final String emailCliente;
  final String senhaCliente;
  final bool statusContaCliente;
  // final Endereco endereco;

  const Cliente({
    required this.idCliente,
    required this.nomeCliente,
    required this.cpfCliente,
    required this.emailCliente,
    required this.senhaCliente,
    required this.statusContaCliente,
    // required this.endereco,
  });
}
