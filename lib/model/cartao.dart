class Cartao {
  final int idCartao;
  final String apelidoCartao;
  final String numerosCartao;
  final String cvv;
  final String dataValidade;
  final String nomeTitular;

  const Cartao({
    required this.idCartao,
    required this.apelidoCartao,
    required this.numerosCartao,
    required this.cvv,
    required this.dataValidade,
    required this.nomeTitular,
  });
}
