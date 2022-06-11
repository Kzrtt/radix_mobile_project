class Produtos {
  final int idProduto;
  final String nomeProduto;
  final String urlFoto;
  final String detalheProduto;
  final double preco;
  final bool statusProduto;

  const Produtos({
    required this.idProduto,
    required this.nomeProduto,
    required this.urlFoto,
    required this.detalheProduto,
    required this.preco,
    required this.statusProduto,
  });
}
