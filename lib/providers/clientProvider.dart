// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:radix_mobile_project/model/cliente.dart';
import 'package:radix_mobile_project/model/vendedor.dart';
import '../data/dummyData.dart';

class ClientProvider with ChangeNotifier {
  List<Cliente> _clientes = DUMMY_CLIENTS;
  List<Vendedor> _vendedoresFavoritos = [];

  List<Cliente> get getClientes => [..._clientes];
  List<Vendedor> get getVendedoresFavoritos => [..._vendedoresFavoritos];
  Cliente get user => _clientes.singleWhere((element) => element.isUser == true);

  bool isFavorite(Vendedor vendedor) {
    return _vendedoresFavoritos.any((element) => element.idVendedor == vendedor.idVendedor);
  }

  void addToFavorites(Vendedor vendedor) {
    _vendedoresFavoritos.add(vendedor);
    notifyListeners();
  }

  void removeFromFavorites(String id) {
    _vendedoresFavoritos.removeWhere((element) => element.idVendedor.toString() == id);
    notifyListeners();
  }

  List<dynamic> loginValidate(String email, String senha) {
    List<dynamic> list = [];
    Cliente? cliente;

    if (_clientes.any((c) => c.emailCliente == email && c.senhaCliente == senha)) {
      _clientes.forEach((element) {
        if (element.emailCliente == email && element.senhaCliente == senha) {
          cliente = element;
        }
      });
      cliente?.isUser == true;
      list.add(true);
      list.add(cliente);
    } else {
      list.add(false);
    }

    return list;
  }

  void addCliente(Cliente cliente) {
    _clientes.add(cliente);
    notifyListeners();
  }

  void deleteCliente(String id) {
    _clientes.removeWhere((c) => c.idCliente.toString() == id);
    notifyListeners();
  }
}
