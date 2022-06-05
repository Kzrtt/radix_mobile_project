class Endereco {
  final String idEndereco;
  final String apelidoEndereco;
  final String endereco;
  final String complemento;
  final String numero;
  final bool isEnderecoPrincipal;
  final bool statusEndereco;

  const Endereco({
    required this.idEndereco,
    required this.apelidoEndereco,
    required this.endereco,
    required this.complemento,
    required this.numero,
    required this.isEnderecoPrincipal,
    required this.statusEndereco,
  });
}
