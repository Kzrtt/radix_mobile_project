import 'package:flutter/cupertino.dart';

class Endereco with ChangeNotifier {
  final String idEndereco;
  final String apelidoEndereco;
  final String endereco;
  final String complemento;
  final String numero;
  bool isEnderecoPrincipal;
  bool statusEndereco;

  Endereco({
    required this.idEndereco,
    required this.apelidoEndereco,
    required this.endereco,
    required this.complemento,
    required this.numero,
    this.isEnderecoPrincipal = false,
    this.statusEndereco = true,
  });

  void isPrincipalAdress() {
    isEnderecoPrincipal = !isEnderecoPrincipal;
    notifyListeners();
  }
}
