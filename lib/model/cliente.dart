class Cliente {
  final int idCliente;
  final String nomeCliente;
  final String cpfCliente;
  final String emailCliente;
  final String senhaCliente;
  bool statusContaCliente;
  bool isUser;
  // final Endereco endereco;

  Cliente({
    required this.idCliente,
    required this.nomeCliente,
    required this.cpfCliente,
    required this.emailCliente,
    required this.senhaCliente,
    this.statusContaCliente = true,
    this.isUser = false,
    // required this.endereco,
  });

  void set setIsUser(bool state) {
    isUser = state;
  }
}
