import 'produtos.dart';

class Vendedor {
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

  const Vendedor({
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
