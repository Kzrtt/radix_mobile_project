class Produtos {
  final int idProduto;
  final String nomeProduto;
  final String urlFoto;
  final String detalheProduto;
  final int preco;
  final int statusProduto;
  final int idVendedor;

  const Produtos({
    required this.idProduto,
    required this.nomeProduto,
    required this.urlFoto,
    required this.detalheProduto,
    required this.preco,
    required this.statusProduto,
    required this.idVendedor,
  });
}
